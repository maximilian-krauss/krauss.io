path    = require('path')
appRoot = path.dirname require.main.filename
teaser  = require '../app_modules/teaser'

#
# * GET /
# * home page.
#
exports.index = (req, res) ->
	res.sendfile path.join(appRoot, '..', 'public', 'html', 'index.html')
	return

#
# * GET /api/teaser-image?l=location
# * teaser image
#
exports.teaserImage = (req, res) ->
	res.send teaser.image req.query.l
	return