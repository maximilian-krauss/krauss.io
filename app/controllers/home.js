var cache = require('memory-cache'),
    thresholdInMS = 10 * 60 * 1000; //5 Minutes

module.exports = function() {
  var app = this.app,
      core = this.core;

  app.get('/', function(req, res) {

    var cachedItems = cache.get('postItems');
    if(cachedItems) {
      return res.render('home', { posts: cachedItems })
    }

    core.feedFetcher(function(err, postItems) {
      cache.put('postItems', postItems, thresholdInMS);
      res.render('home', {
        posts: postItems
      });
    });
  });
};
