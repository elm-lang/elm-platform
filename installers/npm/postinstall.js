var path = require("path");
var fs = require("fs");
var osFilter = require("os-filter-obj");
var https = require("follow-redirects").https;
var tar = require("tar");
var zlib = require("zlib");
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

var filename = applicableBinaries.filename;
var url = "https://dl.bintray.com/elmlang/elm-platform/"
  + version + "/" + filename;

console.log("Downloading " + url);

https.get(url, function(response) {
  var untar = tar.Extract({path: distDir, strip: 1})
    .on("error", function(error) {
      console.error("Error extracting", filename, error);
      process.exit(1);
    })
    .on("end", function() {
      console.log("Successfully processed", filename);
    });

  var gunzip = zlib.createGunzip()
    .on("error", function(error) {
      console.error("Error decompressing", filename, error);
      process.exit(1);
    });

  response.on("error", function(error) {
    console.error("Error receiving", url);
    process.exit(1);
  }).pipe(gunzip).pipe(untar);
}).on("error", function(error) {
  console.error("Error communicating with URL ", url, error);
  process.exit(1)
});
