var Promise = require("promise");
var path = require("path");
var platform = require(path.join(__dirname, "platform"));
var spawn = require("child_process").spawn;
var path = require("path");
var fs = require("fs");
var https = require("follow-redirects").https;
var tar = require("tar");
var zlib = require("zlib");
var mkdirp = require("mkdirp");
var distDir = path.join(__dirname, "Elm-Platform", platform.elmVersion, ".cabal-sandbox", "bin");
var expectedExecutablePaths = platform.executables.map(function(executable) {
  return path.join(distDir, executable);
});

function checkBinariesPresent() {
  return Promise.all(
    expectedExecutablePaths.map(function(executable) {
      return new Promise(function(resolve, reject) {
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
    })
  );
}

function downloadBinaries() {
  return new Promise(function(resolve, reject) {
    if (!fs.existsSync(distDir)) {
      mkdirp.sync(distDir);
    }

    // 'arm', 'ia32', or 'x64'.
    var arch = process.arch;

    //'darwin', 'freebsd', 'linux', 'sunos' or 'win32'
    var operatingSystem = process.platform;

    var filename = operatingSystem + "-" + arch + ".tar.gz";
    var url = "https://dl.bintray.com/elmlang/elm-platform/"
      + platform.elmVersion + "/" + filename;

    https.get(url, function(response) {
      if (response.statusCode == 404) {
        console.log("There are currently no Elm Platform binaries available for your operating system and architecture. Building from source...");

        return platform.buildFromSource().then(resolve, reject);
      }

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
              console.error("Expected these executables to be in", distDir, " - ", platform.executables);
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
  console.error(errorMsg);
  process.exit(1);
});
