var Bintray = require("bintray");
var path = require("path");
var fs = require("fs");
var args = require('yargs')
    .demand(2)
    .argv
    ._;

var version = args[0];
var filePath = args[1];

if (!fs.existsSync(filePath)) {
  console.error("Cannot find upload file " + filePath);

  process.exit(1);
}

var organizationName = "elmlang"
var repositoryName = "elm-platform"
var packageName = "npm";
var bintrayFilename = "bintray.json";
var bintraySettings;

try {
    bintraySettings = require(path.resolve(bintrayFilename));
} catch (err) {
    console.error("Could not import file " + bintrayFilename
        + " - see UPLOADING.md for instructions on how to create one.");

    process.exit(1);
}

var repository = new Bintray({
  username: bintraySettings.username,
  apikey: bintraySettings.key,
  organization: organizationName,
  repository: repositoryName
});

repository.uploadPackage(packageName, version, filePath)
  .then(function (response) {
    console.log("Success!", response.data);
  }, function(error) {
    if (error.code === 404) {
      console.error("The " + packageName + " package does not have a version "
        + version + " yet. Please visit http://bintray.com and add it!")
    } else {
      console.error(
        "Error accessing package \"" + packageName
        + "\" in repository \"" + repositoryName
        + "\":\n" + error.code + " " + error.status
      );

      process.exit(1);
    }
  });
