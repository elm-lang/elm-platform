var path = require("path");
var version = require('./package.json').version;

// Use major.minor.patch from version string - e.g. "1.2.3" from "1.2.3-alpha"
var distDir = path.join("Elm-Platform",
    version.replace(/^(\d+\.\d+\.\d+).*$/, "$1"));

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
