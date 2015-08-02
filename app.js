var _ = require('lodash'),
    all = require('require-tree')
    express = require('express'),
    compression = require('compression'),
    exphbs = require('express-handlebars'),
    colors = require('colors'),
    app = express();

var controllers = all('./app/controllers'),
    core = require('./app/core'),
    bundles = {};

var hbs = exphbs.create({
  defaultLayout: 'main',
  helpers: {
    title: function() {
      return 'Maximilian Krauß';
    },
    teaserUrl: function() {
      return '/dynamic/teaser.jpg';
    },
    css: function(file) {
      return bundles.css(file);
    },
    js: function(file) {
      return bundles.js(file);
    }
  }
});

app.use(compression({ threshold: 512 }));
app.engine('handlebars', hbs.engine);
app.set('view engine', 'handlebars');
app.set('etag', 'strong');

app.use(require('connect-assets')({
  paths: [
    'media/js',
    'media/css'
  ],
  helperContext: bundles,
  build: true,
  fingerprinting: true,
  servePath: 'media/dist'
}));

app.use('/static/teasers', express.static(__dirname + '/media/teasers', {
    maxAge: '364d',
}));

_.each(controllers, function(controller) {
  controller.apply({
    app: app,
    core: core
  });
});

app.get('*', function(req, res) {
  res.status(404).render('four-oh-four', {
    title: 'Four-Oh-Four'
  });
});

function fireAndForget() {
  var port = process.env.PORT || 7070;

  var server = app.listen(port, function() {
    var h = server.address().address;
    var p = server.address().port;

    console.log('Awesome. Web. So much running at http://%s:%s'.green, h, p); // Baxxter
  });
}

fireAndForget();
