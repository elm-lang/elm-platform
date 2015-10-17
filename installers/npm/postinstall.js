var path = require("path");
var fs = require("fs");
var temp = require("temp").track();
var osFilter = require("os-filter-obj");
var httpreq = require("httpreq");
var ProgressBar = require("progress");
var Decompress = require("decompress");
var version = require(path.join(__dirname, "package.json")).version;
var mappings = require(path.join(__dirname, "binaries.json"));
var applicableBinaries = osFilter(mappings.binaries)[0];
var distDir = "dist";

if (!applicableBinaries) {
  console.error("There are currently no Elm Platform binaries available for your operating system and architecture.")

  process.exit(1);
}

if (!fs.existsSync(distDir)) {
  fs.mkdirSync(distDir);
}

temp.mkdir('elm-platform-download', function(err, tempDir) {
  var filename = applicableBinaries.filename;
  var downloadedFilename = path.join(tempDir, filename);
  var url = "https://dl.bintray.com/elmlang/elm-platform/"
    + version + "/" + filename;

  console.log("Downloading " + url);

  console.log();
  var bar = null;

  httpreq.download(url, downloadedFilename,
    function (err, progress){
      if (err) {
        console.error("Error communicating with URL ", url, error);
        process.exit(1);
      }

      if (bar === null) {
        bar = new ProgressBar('  downloading [:bar] :percent :etas', {
            complete: '=',
            incomplete: ' ',
            width: 20,
            total: parseInt(progress.totalsize)
          });
      }

      bar.tick(progress.currentsize);
    }, function (err, res){
      if (err) {
        console.error("Error receiving data from ", url, err);
        process.exit(1);
      }

      new Decompress({mode: "755", strip: 1})
        .src(downloadedFilename)
        .dest(distDir)
        .run(function(error, files) {
          if (error) {
            console.error("Error extracting ", downloadedFilename, error);
            process.exit(1);
          }

          if (files.length < 1) {
            console.error("This downloaded archive should have contained Elm executables, but was empty: ", downloadedFilename);
            process.exit(1);
          }

          console.log("Successfully received " + files.length + " Elm executables.")
        });
    });
});


