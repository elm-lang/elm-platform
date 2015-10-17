var path = require("path");
var fs = require("fs");
var temp = require("temp").track();
var osFilter = require("os-filter-obj");
var Download = require("download");
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
  var destFilename = path.join(distDir, filename);
  var url = "http://dl.bintray.com/elmlang/elm-platform/"
    + version + "/" + filename;

  console.log("Downloading " + url);

  new Download({mode: "755"}).get(url, tempDir).run(function() {
    new Decompress({mode: "755", strip: 1})
      .src(path.join(tempDir, filename))
      .dest(distDir)
      .run();
  });
});


