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
  var untar = tar.Extract({path: distDir, strip: 1});

  response.pipe(zlib.createGunzip()).pipe(untar);
}).on("error", function(error) {
  console.error("Error communicating with URL ", url, error);
  process.exit(1)
});
