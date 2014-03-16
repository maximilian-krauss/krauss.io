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
dotenv      = require "dotenv"
seojs			 = require "express-seojs"
env				 = require "./app_modules/environment"
app         = express()

# all environments
app.set "port", process.env.PORT or 3000
app.use express.compress()
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

dotenv.load()


if (env.get("NODE_ENV")? is "production")
	console.log "production ftw!"
	app.use(seojs(env.get("SEOJS_TOKEN")))

# development only
app.use express.errorHandler()  if "development" is app.get("env")

# api
app.get "/api/projects", project.list
app.get "/api/github/:name", project.githubFacts
app.get "/api/project/:name", project.detail
app.get "/api/reports/:name", reporting.appReport
app.get "/api/blog/latest", blog.latest
app.get "/api/teaser-image", routes.teaserImage
app.get "/api/raw-teaser-image", routes.rawTeaserImage

# SPA view
app.get "*", routes.index

http.createServer(app).listen app.get("port"), ->
	console.log "Yippie kay yeah motherfuckers, battleship up and running on port " + app.get("port")
	return
