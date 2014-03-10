_       = require("underscore")
fs      = require('fs')
path    = require('path')
config  = require("../config")
appRoot = path.dirname(require.main.filename)

readAndConvertImageContents = (path, callback) ->
	fs.readFile(path, null, (err, data)->
		if err
			callback err
		else
			callback null, new Buffer(data, 'binary').toString('base64')
		return
	)
	return

#
# * GET /
# * home page.
#
exports.index = (req, res) ->
	res.sendfile( path.join(appRoot, '..', 'public', 'html', 'index.html') )
	return


#
# * GET /api/teaser-image?l=location
# * teaser image
#
exports.teaserImage = (req, res) ->
	location = req.query.l
	imageLocation = "/" + [
		"static"
		"images"
	].join("/")
	fallbackImageUrl = [
		imageLocation
		config.app.fallbackTeaser
	].join("/")
	if location isnt `undefined`
		teaser = _(config.app.teaserMap).find((item) ->
			item.location.toLowerCase() is location.toLowerCase()
		)
		if teaser isnt `undefined`
			res.send [
				imageLocation
				teaser.image
			].join("/")
			return
	res.send fallbackImageUrl
	return

exports.rawTeaserImage = (req, res) ->
	location = req.query.l
	imagePath = path.join appRoot, '..', 'public', 'images'
	imageLocation = path.join imagePath, config.app.fallbackTeaser

	if location?
		teaser = _(config.app.teaserMap).find((item) ->
			item.location.toLowerCase() is location.toLowerCase()
		)
		if teaser?
			imageLocation = path.join imagePath, teaser.image

	readAndConvertImageContents imageLocation, (err, data) ->
		res.send { data: data }
		return

	return