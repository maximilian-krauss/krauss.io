module.exports = function() {
  var app = this.app,
      core = this.core;

  app.get('/projects', function(req, res) {
    res.render('projects', {
      subTitle: 'Projects'
    })
  });
};
