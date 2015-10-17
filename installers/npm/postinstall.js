var path = require("path");
var fs = require("fs");
var temp = require("temp").track();
var osFilter = require("os-filter-obj");
var https = require("follow-redirects").https;
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

  https.get(url, function(response) {
    var writeStream = fs.createWriteStream(downloadedFilename);

    writeStream.on("close", function() {
      new Decompress({mode: "755", strip: 1})
        .src(downloadedFilename)
        .dest(distDir)
        .run();
    });

    writeStream.on("error", function(error) {
      console.error("Error receiving data from ", url, error);
    });

    response.pipe(writeStream);
  }).on("error", function(error) {
    console.error("Error communicating with URL ", url, error);
  });
});


