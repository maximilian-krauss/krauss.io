_ = require("underscore")
pings = require("../app_modules/pings")
config = require("../config")
module.exports.appReport = (req, res) ->
	project = _(config.projects).find((proj) ->
		proj.id.toLowerCase() is req.params.name.toLowerCase()
	)
	if project is `undefined`
		res.status(404).send()
		return
	pings.appReport project.id, ((results) ->
		res.send results
		return
	), (err) ->
		res.status(400).send "something went wrong"
		return

	return