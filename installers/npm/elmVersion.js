var path = require("path");
var version = require(path.join(__dirname, "package.json")).version;

// Use major.minor.patch from version string - e.g. "1.2.3" from "1.2.3-alpha"
module.exports = version.replace(/^(\d+\.\d+\.\d+).*$/, "$1");
