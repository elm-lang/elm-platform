var Promise = require("promise");
var path = require("path");
var packageInfo = require(path.join(__dirname, "package.json"));
var spawn = require("child_process").spawn;

// Use major.minor.patch from version string - e.g. "1.2.3" from "1.2.3-alpha"
var elmVersion = packageInfo.version.replace(/^(\d+\.\d+\.\d+).*$/, "$1");
var platformDir = path.join(__dirname, "Elm-Platform", elmVersion);
var distDir = path.join(platformDir, ".cabal-sandbox", "bin");
var shareDir = path.join(platformDir, "share");
var shareReactorDir = path.join(shareDir, "reactor");
var executables = Object.keys(packageInfo.bin);
var binaryExtension = process.platform === "win32" ? ".exe" : "";
var executablePaths = {};

executables.forEach(function(executable) {
  executablePaths[executable] = path.join(distDir, executable + binaryExtension);
});

module.exports = {
  packageInfo: packageInfo,
  elmVersion: elmVersion,
  distDir: distDir,
  shareDir: shareDir,
  shareReactorDir: shareReactorDir,
  executablePaths: executablePaths,
  executables: executables
};
