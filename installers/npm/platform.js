var Promise = require("promise");
var path = require("path");
var packageInfo = require(path.join(__dirname, "package.json"));
var spawn = require("child_process").spawn;

// Use major.minor.patch from version string - e.g. "1.2.3" from "1.2.3-alpha"
var elmVersion = packageInfo.version.replace(/^(\d+\.\d+\.\d+).*$/, "$1");
var distDir = path.join(__dirname, "Elm-Platform", elmVersion, ".cabal-sandbox", "bin");

function buildFromSource() {
  return new Promise(function(resolve, reject) {
    // From the "build from source" docs:
    //
    // Now that you have chosen a home for Elm-Platform/, add the absolute path
    // to Elm-Platform/0.15.1/.cabal-sandbox/bin to your PATH. This is
    // necessary to successfully build elm-reactor which relies on elm-make.
    process.env.PATH = (process.env.PATH || "").split(":").concat([distDir]).join(":");

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
  distDir: distDir,
  executables: Object.keys(packageInfo.bin)
};
