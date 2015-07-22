var _ = require('lodash'),
    parser = require('rssparser'),
    str = require('string');

var feedUrl = 'http://blog.krauss.io/rss/';

module.exports = function(cb) {

  var options = {};
  parser.parseURL(feedUrl, options, function(err, out) {
    if(err) {
      return cb(err);
    }

    var posts = [];

    _.forEach(out.items, function(item) {
      posts.push({
        postTitle: str(item.title).unescapeHTML().s,
        timeAgo: item.time_ago,
        url: item.url
      });
    });

    cb(null, posts);
  });
};
