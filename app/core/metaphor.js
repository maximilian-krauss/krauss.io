var _ = require('lodash'),
    endpoint = process.env.KRAUSS_METAPHOR_ENDPOINT,
    apiKey = process.env.KRAUSS_METAPHOR_API_KEY,
    request = require('request');

function _askMetaphor(items, callback) {
  var options = {
    url: endpoint,
    method: 'POST',
    headers: {
      'X-Api-Key': apiKey
    },
    json: items
  };

  request(options, function(err, response, body) {
    if(err || response.statusCode !== 200) {
      return callback(err || new Error('metaphor request failed'));
    }

    callback(null, body);
  });
}

module.exports = function(items, callback) {
  var requestToMetapher = _(items).map(function(item) { return item.url }).value();

  _askMetaphor(requestToMetapher, function(err, rendered) {
    if(err) {
      return callback(err);
    }

    var merged = _(rendered)
      .map(function(r) {
        return _.extend(r, items[r.index]);
      })
      .value();

    callback(null, rendered);
  });
};
