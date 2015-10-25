var path = require("path");
var elmVersion = require("./elmVersion");
var distDir = path.join("Elm-Platform", elmVersion, ".cabal-sandbox", "bin");

var paths = {};
var executables = [
    "elm",
    "elm-make",
    "elm-package",
    "elm-reactor",
    "elm-repl"
];

executables.forEach(function (executable) {
    var extension = process.platform === "win32" ? ".exe" : "";

    paths[executable] = path.join(__dirname, distDir, (executable + extension));
});

function getPathTo(executable) {
    return paths[executable];
}

module.exports = { getPathTo: getPathTo };
