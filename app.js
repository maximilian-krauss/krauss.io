var _ = require('lodash'),
    all = require('require-tree')
    express = require('express'),
    compression = require('compression'),
    exphbs = require('express-handlebars'),
    colors = require('colors'),
    fs = require('fs'),
    path = require('path'),
    marked = require('marked'),
    dotenv = require('dotenv').load(),
    app = express();

var controllers = all('./app/controllers'),
    core = require('./app/core'),
    bundles = {};

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
    },
    md: _renderMarkdown
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

app.use('/static/images', express.static(__dirname + '/media/images', {
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
