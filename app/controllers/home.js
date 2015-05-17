module.exports = function() {
  var app = this.app,
      core = this.core;

  app.get('/', function(req, res) {
    res.render('home');
  });
};
