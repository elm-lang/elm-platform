var binstall = require("binstall");
var path = require("path");
var fs = require("fs-extra");
var packageInfo = require(path.join(__dirname, "package.json"));

// Use major.minor.patch from version string - e.g. "1.2.3" from "1.2.3-alpha"
var binVersion = packageInfo.version.replace(/^(\d+\.\d+\.\d+).*$/, "$1");

// 'arm', 'ia32', or 'x64'.
var arch = process.arch;

// 'darwin', 'freebsd', 'linux', 'sunos' or 'win32'
var operatingSystem = process.platform;

var filename = operatingSystem + "-" + arch + ".tar.gz";
var url = "https://dl.bintray.com/elmlang/elm-platform/"
  + binVersion + "/" + filename;

var binariesDir = path.join(__dirname, "binaries");
var packageInfo = require(path.join(__dirname, "package.json"));
var binaryExtension = process.platform === "win32" ? ".exe" : "";
var executablePaths = Object.keys(packageInfo.bin).map(function(executable) {
  return path.join(binariesDir, executable + binaryExtension);
});
var errorMessage = "Unfortunately, there are no Elm Platform " + binVersion + " binaries available for your operating system and architecture.\n\nIf you would like to build Elm from source, there are instructions at https://github.com/elm-lang/elm-platform#build-from-source\n";

binstall(url, {path: binariesDir, strip: 1},
  {verbose: true, verify: executablePaths, errorMessage: errorMessage}
).then(function(successMessage) {
    // Linux
    if(operatingSystem == "linux") {
      console.log("Overriding elm-make binary to allow GHC flags.")
      fs.copySync(binariesDir + "/linux/elm-make.linux.x64", binariesDir + "/elm-make", {overwrite: true})
      console.log("Elm-make binary overridden. Please pass GHC flags for optimum performance.")
    }
    // MacOS
    else if(operatingSystem == "darwin") {
      console.log("Overriding elm-make binary to allow GHC flags.")
      fs.copySync(binariesDir + "/mac/elm-make.darwin", binariesDir + "/elm-make", {overwrite: true})
      console.log("Elm-make binary overridden. Please pass GHC flags for optimum performance.")
    }
    console.log(successMessage);
  }, function(errorMessage) {
    console.error(errorMessage);
    process.exit(1);
  });
