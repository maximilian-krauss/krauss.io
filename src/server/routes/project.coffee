path    = require("path")
fs      = require("fs")
https   = require("https")
_       = require("underscore")
config  = require("../config")
appRoot = path.dirname(require.main.filename)
env     = require("../app_modules/environment")
github  = require("../app_modules/github")

findProject = (projectId) ->
	_.find config.projects, (project) ->
		project.id.toLowerCase() is projectId.toLowerCase()



#
# * GET /api/projects
# * Returns the list with all projects
#
exports.list = (req, res) ->
	res.send config.projects
	return


#
# * GET /api/project/:name
# * Returns details of the specified project
#
exports.detail = (req, res) ->
	project = findProject(req.params.name)
	if project is `undefined`
		res.status(404).send "project not found"
		return
	try
		res.header "Content-Type", "application/json"
		res.send fs.readFileSync(path.join(appRoot, "public", "project-assets", project.id, "app.json"), "utf8")
	catch err
		res.status(404).send "project not found"
	return


#
# * GET /api/github/:name
# * Returns some github facts about the specific request
#
exports.githubFacts = (req, res) ->
	project = findProject(req.params.name)
	if project is `undefined`
		res.status(404).send()
		return
	github.repoDetails project.id, ((data) ->
		res.send data
		return
	), (err) ->
		res.status(400).send()
		return

	return