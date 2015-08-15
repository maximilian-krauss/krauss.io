module.exports = function() {
  var app = this.app,
      core = this.core;

  app.get('/about', function(req, res) {
    res.render('about', { subTitle: 'About' });
  });
};
