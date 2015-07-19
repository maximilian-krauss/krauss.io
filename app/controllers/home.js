module.exports = function() {
  var app = this.app,
      core = this.core;

  app.get('/', function(req, res) {

    core.feedFetcher(function(err, postItems) {
      res.render('home', {
        posts: postItems
      });
    });
  });
};
