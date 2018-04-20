var binwrap = require("binwrap");
var path = require("path");

var packageInfo = require(path.join(__dirname, "package.json"));
// Use major.minor.patch from version string - e.g. "1.2.3" from "1.2.3-alpha"
var binVersion = packageInfo.version.replace(/^(\d+\.\d+\.\d+).*$/, "$1");

var root = "https://github.com/elm-lang/elm-platform/releases/download/" + binVersion + "-exp/elm-platform";

module.exports = binwrap({
  binaries: ["elm", "elm-make", "elm-repl", "elm-reactor", "elm-package"],
  urls: {
    "darwin-x64": root + "-macos.tar.gz",
    "win32-x64": root + "-windows.tar.gz",
    "win32-ia32": root + "-windows.tar.gz",
    "linux-x64": root + "-linux-64bit.tar.gz",
    "linux-ia32": root + "-linux-32bit.tar.gz"
  }
});

