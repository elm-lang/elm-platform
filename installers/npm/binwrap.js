var path = require("path");
var spawn = require("child_process").spawn;
var platform = require(path.join(__dirname, "platform"));

module.exports = function(executable) {
  var input = process.argv.slice(2);

  process.env.ELM_HOME = platform.shareDir;

  spawn(platform.executablePaths[executable], input, {stdio: 'inherit'})
    .on('exit', process.exit);
};
