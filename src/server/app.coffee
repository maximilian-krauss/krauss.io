###
Module dependencies.
###
express     = require "express"
routes      = require "./routes"
project     = require "./routes/project"
blog        = require "./routes/blog"
reporting   = require "./routes/reporting"
graveyard   = require "./middleware/graveyard"
http        = require "http"
path        = require "path"
app         = express()

# all environments
app.set "port", process.env.PORT or 3000
#app.set "views", "#{__dirname}/views"
#app.set "view engine", "jade"
app.use express.logger("dev")
app.use express.urlencoded()
app.use express.json()
app.use express.methodOverride()
app.use "/static", express.static(path.join(__dirname, "../public"))
app.use "/static-vendor", express.static(path.join(__dirname, "../bower_components"))
app.use express.favicon(path.join(__dirname, "../public/images/favicon.ico"))
app.use graveyard.reaper
app.use app.router
app.disable "x-powered-by"

# development only
app.use express.errorHandler()  if "development" is app.get("env")

# view engine
app.get "/", routes.index
app.get "/partials/directives/:name", routes.directive
app.get "/partials/:name", routes.partial

# api
app.get "/api/projects", project.list
app.get "/api/github/:name", project.githubFacts
app.get "/api/project/:name", project.detail
app.get "/api/reports/:name", reporting.appReport
app.get "/api/blog/latest", blog.latest
app.get "/api/teaser-image", routes.teaserImage
app.get "/api/raw-teaser-image", routes.rawTeaserImage

# fallback
app.get "*", routes.index
http.createServer(app).listen app.get("port"), ->
	console.log "Yippie kay yeah motherfuckers, battleship up and running on port " + app.get("port")
	return
