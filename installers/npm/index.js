var path = require("path");
var platform = require(path.join(__dirname, "platform"));
var distDir = path.join("Elm-Platform", platform.elmVersion, ".cabal-sandbox", "bin");

var paths = {};

platform.executables.forEach(function (executable) {
    paths[executable] = path.join(__dirname, distDir, executable + platform.binaryExtension);
});

function getPathTo(executable) {
    return paths[executable];
}

module.exports = { getPathTo: getPathTo };
