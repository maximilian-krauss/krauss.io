var _ = require('lodash'),
    parser = require('feed-read'),
    moment = require('moment');

var feedUrl = 'https://max.krauss.io/rss/';

module.exports = function(cb) {

  parser(feedUrl, (err, articles) => {
    if(err) {
      return cb(err);
    }

    var posts = _(articles)
      .chain()
      .map((a) => {
        return {
          postTitle: a.title,
          timeAgo: moment(a.published).fromNow(),
          url: a.link
        };
      })
      .value();

    cb(null, posts);
  });
};
