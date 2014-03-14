_       = require 'underscore'
config  = require '../config'

module.exports.image = (location) ->
	imageLocation = "/" + [	"static", "images"].join "/"
	fallbackImageUrl = [imageLocation, config.app.fallbackTeaser].join "/"

	if location?
		teaserForLocation = _(config.app.teaserMap).find((item) ->
			item.location.toLowerCase() is location.toLowerCase()
		)
		if teaserForLocation?
			return [imageLocation, teaserForLocation.image].join '/'

	fallbackImageUrl