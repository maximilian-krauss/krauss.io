var fs = require('fs');

_randomize = function(array) {
  return array[Math.floor(Math.random() * array.length)]
};

module.exports = function(cb) {
  fs.readdir('./media/teasers', function(err, teasers) {
    if(err) {
      return cb(err);
    }

    if(!teasers.length) {
      return cb(new Error('No teaser images found.'));
    }

    return cb(null, _randomize(teasers));
  });
};
