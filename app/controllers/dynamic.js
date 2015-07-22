var express = require('express'),
    path = require('path'),
    appDir = path.dirname(require.main.filename);

module.exports = function() {
  var app = this.app,
      core = this.core;

  app.get('/dynamic/teaser.jpg', function(req, res) {
    core.teaserRoulette(function(err, teaser) {
      if(err) {
        core.log.error(__filename, err);
        return res.status(404).send();
      }

      var responseOptions = {
        root: appDir,
        maxAge: 0,
        lastModified: false,
        headers: {
          'Cache-Control': 'no-cache, no-store, must-revalidate',
          'Pragma': 'no-cache',
          'Expires': '0',
        }
      };

      res.sendFile(teaser, responseOptions, function(err) {
        if(err) {
          core.log.error(__filename, err);
          return res.status(err.status).end();
        }
      });

    });
  });
};
