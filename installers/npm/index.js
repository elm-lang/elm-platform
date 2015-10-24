var path = require("path");

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

    paths[executable] = path.join(__dirname, "dist", (executable + extension));
});

function getPathTo(executable) {
    return paths[executable];
}

module.exports = { getPathTo: getPathTo };
