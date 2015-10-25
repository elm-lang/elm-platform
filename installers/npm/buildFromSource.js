var path = require("path");
var platform = require(path.join(__dirname, "platform"));

platform.buildFromSource().then(function() {
  console.log("Successfully built from source.");
}, function(exitCode) {
  console.error("Error - building from source failed to complete.");
  process.exit(exitCode);
});
