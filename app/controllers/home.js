'use strict'

const cache = require('memory-cache'),
      thresholdInMS = 60 * 60 * 1000; //1h

module.exports = function() {
  var app = this.app,
      kugelblitz = this.kugelblitz,
      core = this.core;

  app.get('/', function(req, res) {

    var cachedItems = cache.get('postItems');
    if(cachedItems) {
      return res.render('home', { posts: cachedItems })
    }

    core.feedFetcher((err, postItems) => {
      if(err) {
        kugelblitz.reportError(err).then(_ => { res.redirect('/500'); });
        return;
      }

      cache.put('postItems', postItems, thresholdInMS);
      res.render('home', {
        posts: postItems
      });
    });
  });
};
