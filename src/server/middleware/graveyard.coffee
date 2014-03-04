_       = require("underscore")
config  = require("../config")

module.exports.reaper = (req, res, next) ->
	redirection = _(config.app.graveyard).find((item) ->
		req.path.toLowerCase() is item.request.toLowerCase()
	)
	if redirection isnt `undefined`
		res.redirect 301, redirection.response
	else
		next()
	return
