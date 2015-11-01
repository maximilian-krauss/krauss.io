'use strict'

module.exports = function() {
  let app = this.app;

  app.get('/pong', (req, res) => {
    return res.status(200).send({ alive: true });
  });
};
