module.exports = function(executable) {
  var filename = require("./").getPathTo(executable);
  var spawn = require("child_process").spawn;
  var input = process.argv.slice(2);

  spawn(filename, input, {stdio: 'inherit'})
    .on('exit', process.exit);
}
