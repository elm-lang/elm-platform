var version = require("./package.json").version;

// Use major.minor.patch from version string - e.g. "1.2.3" from "1.2.3-alpha"
module.exports = version.replace(/^(\d+\.\d+\.\d+).*$/, "$1");
