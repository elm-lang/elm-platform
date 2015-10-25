var Promise = require("promise");
var path = require("path");
var packageInfo = require(path.join(__dirname, "package.json"));
var spawn = require("child_process").spawn;

// Use major.minor.patch from version string - e.g. "1.2.3" from "1.2.3-alpha"
var elmVersion = packageInfo.version.replace(/^(\d+\.\d+\.\d+).*$/, "$1");

function buildFromSource() {
  return new Promise(function(resolve, reject) {
    var child = spawn("runhaskell", ["BuildFromSource.hs", elmVersion],
      {stdio: "inherit"});

    child.on("exit", function(exitCode) {
      if (exitCode === 0) {
        resolve();
      } else {
        reject(exitCode);
      }
    });
  });
}

module.exports = {
  packageInfo: packageInfo,
  elmVersion: elmVersion,
  buildFromSource: buildFromSource,
  executables: Object.keys(packageInfo.bin)
};
