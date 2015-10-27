var path = require("path");
var getPathTo = require(path.join(__dirname, "index")).getPathTo;
var spawn = require("child_process").spawn;

module.exports = function(executable) {
  var filename = getPathTo(executable);
  var input = process.argv.slice(2);

  spawn(filename, input, {stdio: 'inherit'})
    .on('exit', process.exit);
};
