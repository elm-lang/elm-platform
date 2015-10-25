var path = require("path");
var elmVersion = require(path.join(__dirname, "elmVersion"));
var spawn = require("child_process").spawn;
var path = require("path");
var fs = require("fs");
var osFilter = require("os-filter-obj");
var https = require("follow-redirects").https;
var tar = require("tar");
var zlib = require("zlib");
var mappings = require(path.join(__dirname, "binaries.json"));
var applicableBinaries = osFilter(mappings.binaries)[0];
var mkdirp = require("mkdirp");
var distDir = path.join(__dirname, "Elm-Platform", elmVersion, ".cabal-sandbox", "bin");
var expectedExecutables = [
  "elm", "elm-make", "elm-repl", "elm-package", "elm-reactor"
];

function checkBinariesPresent() {
  return Promise.all(
    expectedExecutablePaths.map(function(executable) {
      fs.stat(executable, function(err, stats) {
        if (err) {
          reject(executable + " was not found.");
        } else if (!stats.isFile()) {
          reject(executable + " was not a file.");
        } else {
          resolve();
        }
      });
    });
  }));
}

function downloadBinaries() {
  return new Promise(function(resolve, reject) {
    if (!applicableBinaries) {
      reject("There are currently no Elm Platform binaries available for your operating system and architecture.")
    }

    if (!fs.existsSync(distDir)) {
      fs.mkdirSync(distDir);
    }

    var filename = applicableBinaries.filename;
    var url = "https://dl.bintray.com/elmlang/elm-platform/"
      + version + "/" + filename;

    console.log("Downloading " + url);

    https.get(url, function(response) {
      var untar = tar.Extract({path: distDir, strip: 1})
        .on("error", function(error) {
          reject("Error extracting " + filename + " - " + error);
        })
        .on("end", function() {
          if (!fs.existsSync(distDir)) {
            reject(
              "Error extracting executables: extraction finished, but",
              distDir, "directory was not created.\n" +
              "Current directory contents: " + fs.readdirSync(__dirname)
            );
          }

          if (!fs.statSync(distDir).isDirectory()) {
            reject(
              "Error extracting executables: extraction finished, but" +
              distDir + "ended up being a file, not a directory. " +
              "This can happen when the .tar.gz file contained the " +
              "binaries directly, instead of containing a directory with " +
              "the files inside.");
          }

          checkBinariesPresent().then(function() {
              resolve("Successfully downloaded and processed " + filename);
            }, function(error) {
              console.error("Error extracting executables...");
              console.error("Expected these executables to be in", distDir, " - ", expectedExecutables);
              console.error("...but got these contents instead:", fs.readdirSync(distDir));

              reject(error);
            }
          );
        });

      var gunzip = zlib.createGunzip()
        .on("error", function(error) {
          reject("Error decompressing " + filename + " " + error);
        });

      response.on("error", function(error) {
        reject("Error receiving " + url);
      }).pipe(gunzip).pipe(untar);
    }).on("error", function(error) {
      reject("Error communicating with URL " + url + " " + error);
    });
  });
}

downloadBinaries().then(function(successMsg) {
  console.log(successMsg);
}, function(errorMsg) {
  console.log("Unable to download Elm binaries for your operating system and architecture. Building from source...");
  require("./buildFromSource");
});
