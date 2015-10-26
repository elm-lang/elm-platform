var path = require("path");
var platform = require(path.join(__dirname, "platform"));

platform.buildFromSource().then(function() {
  console.log("Successfully built from source.");
}, function(exitCode) {
  switch(typeof exitCode) {
    case "string":
      console.error(exitCode);
      process.exit(1);
    case "number":
      console.error("Error - building from source failed with exit code " + exitCode);
      process.exit(exitCode || 1);
    default:
      console.error("Error - building from source failed to complete.");
      process.exit(1);
  }
});
