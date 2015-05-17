var colors = require('colors');

module.exports = {
  error: function(where, what) {
    console.log((where + ': ' + what.message).red);
  }
};
