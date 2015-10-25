var path = require("path");
var elmVersion = require("./elmVersion");
var spawn = require("child_process").spawn;

var child = spawn("runhaskell", ["BuildFromSource.hs", elmVersion], {stdio: "inherit"});

child.on("exit", function(exitCode) {
    process.exit(exitCode);
});
