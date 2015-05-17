var fs = require('fs'),
    path = require('path');

_randomize = function(array) {
  return array[Math.floor(Math.random() * array.length)]
};

module.exports = function(cb) {
  var teaserPath = path.join('media', 'teasers');

  fs.readdir(teaserPath, function(err, teasers) {
    if(err) {
      return cb(err);
    }

    if(!teasers.length) {
      return cb(new Error('No teaser images found.'));
    }

    var teaserImagePath = path.join(teaserPath, _randomize(teasers));
    return cb(null, teaserImagePath);
  });
};
