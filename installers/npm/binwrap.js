var path = require("path");
var getPathTo = require(path.join(__dirname, "index")).getPathTo;
var spawn = require("child_process").spawn;
var platform = require(path.join(__dirname, "platform"));

module.exports = function(executable) {
  var filename = getPathTo(executable);
  var input = process.argv.slice(2);

  process.env.ELM_HOME = platform.shareDir;

  spawn(filename, input, {stdio: 'inherit'})
    .on('exit', process.exit);
};
