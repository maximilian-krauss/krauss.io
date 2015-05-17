var express = require('express');

module.exports = function() {
  var app = this.app,
      core = this.core;

  app.get('/dynamic/teaser.jpg', function(req, res) {
    core.teaserRoulette(function(err, teaserImage) {
      if(err) {
        core.log.error(__filename, err);
        return res.status(404).send();
      }

      res.redirect(301, '/static/teasers/' + teaserImage);
    });
  });
};
