'use strict'

var _ = require('lodash'),
    all = require('require-tree'),
    express = require('express'),
    compression = require('compression'),
    exphbs = require('express-handlebars'),
    colors = require('colors'),
    fs = require('fs'),
    path = require('path'),
    marked = require('marked'),
    morgan = require('morgan'),
    moment = require('moment'),
    dotenv = require('dotenv').load(),
    app = express(),
    config = require('./app/config'),
    kugelblitz = require('kugelblitz-client');

var controllers = all('./app/controllers'),
    core = require('./app/core'),
    bundles = {};

const kgb = new kugelblitz({
  endpoint: config.kugelblitz.endpoint,
  token: config.kugelblitz.token,
  callbackUrl: config.kugelblitz.callbackUrl
});

marked.setOptions({
  renderer: new marked.Renderer(),
  gfm: true,
  tables: true,
  breaks: true,
  pedantic: false,
  sanitize: true,
  smartLists: true,
  smartypants: true
});

function _renderMarkdown(filename) {
  var fileContent = fs.readFileSync(path.join('content', filename + '.md'), { encoding: 'utf-8' });
  return marked(fileContent);
}

function _niceNumber(number) {
  if(number < 11000) {
    return number;
  }

  var kyed = (number / 1000).toFixed(1);
  return kyed + 'k';
}

var hbs = exphbs.create({
  defaultLayout: 'main',
  helpers: {
    title: function() {
      return 'Maximilian Krauß';
    },
    teaserUrl: function() {
      //return '/dynamic/teaser.jpg';
      return '/static/teasers/' + core.teaserRoulette();
    },
    css: function(file) {
      return bundles.css(file);
    },
    js: function(file) {
      return bundles.js(file);
    },
    md: _renderMarkdown,
    mkay: _niceNumber,
    duration: function(d) { return moment.duration(d).humanize(); }
  }
});

app.use(morgan('tiny'));
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
  compress: config.production,
  gzip: config.production,
  fingerprinting: true,
  servePath: 'media/dist'
}));

app.use('/static/teasers', express.static(__dirname + '/media/teasers', {
    maxAge: '364d',
}));

app.use('/static/images', express.static(__dirname + '/media/images', {
    maxAge: '364d',
}));

app.use('/static/vendor', express.static(__dirname + '/bower_components', {
    maxAge: '364d',
}));

if(config.production) {
  app.set('env', process.env);
  app.set('json spaces', undefined);
  app.enable('view cache');
}

_.each(controllers, function(controller) {
  controller.apply({
    app: app,
    core: core,
    kugelblitz: kugelblitz
  });
});

app.get('/500', (req, res) => { res.render('fuckups/http-500', { title: 'HTTP 500' }); });
app.get('*', function(req, res) {
  res.status(404).render('fuckups/http-404', {
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
