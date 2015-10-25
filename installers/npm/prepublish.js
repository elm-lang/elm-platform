var fs = require("fs");

// Copy BuildFromSource.hs into the current dir.
fs.createReadStream("../BuildFromSource.hs").pipe(
    fs.createWriteStream("BuildFromSource.hs"));
