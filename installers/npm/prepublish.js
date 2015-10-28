var path = require("path");
var fs = require("fs");
var filename = "BuildFromSource.hs";

// Copy BuildFromSource.hs into the current dir.
fs.createReadStream(path.join("..", filename)).pipe(
    fs.createWriteStream(filename));
