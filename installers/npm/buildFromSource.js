var path = require("path");
var platform = require(path.join(__dirname, "platform"));

platform.buildFromSource().then(function() {
  console.log("Successfully built from source.");
}, function(exitCode) {
  if (typeof exitCode === "string") {
    console.error(exitCode);
    process.exit(1);
  } else {
    console.error("Error - building from source failed to complete.");

    process.exit(exitCode === 0 ? 1 : exitCode);
  }
});
