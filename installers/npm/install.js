var path = require("path");
var elmVersion = require("./elmVersion");
var spawn = require("child_process").spawn;

console.log("Downloading Elm binaries...");
var child = spawn("node-pre-gyp", ["install"], {stdio: "inherit"});

child.on("exit", function(exitCode) {
    if (exitCode === 0) {
        console.log("Download complete.");
    } else {
        console.log("Unable to download Elm binaries for your operating system and architecture. Building from source...");
        require("./buildFromSource");
    }
});
