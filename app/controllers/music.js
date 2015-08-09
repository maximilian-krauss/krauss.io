var _ = require('lodash'),
    cache = require('memory-cache'),
    cacheThreshold = 10 * 60 * 1000,
    cacheKey = 'rendered-music-stuff',
    likes = require('../../content/music/likes.json');

module.exports = function() {
  var app = this.app,
      core = this.core;

  app.get('/music', function(req, res) {
    var cached = cache.get(cacheKey);
    if(cached) {
      return res.render('music', { items: cached });
    }

    core.metaphor(likes, function(err, rendered) {
      cache.put(cacheKey, rendered, cacheThreshold);
      res.render('music', { items: rendered });
    });
  });
};
