var fs = require('fs'),
    path = require('path'),
    teaserPath = path.join('media', 'teasers');

function _randomize(array) {
  return array[Math.floor(Math.random() * array.length)]
};

function _doSync() {
  return _randomize(fs.readdirSync(teaserPath));
}

module.exports = function() {
    return _doSync();
};
