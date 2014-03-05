parser = require("rssparser")
str = require("string")
config = require("../config")
exports.latest = (req, res) ->
	options = {}
	parser.parseURL config.blog.feedUrl, options, (err, out) ->
		postList = []
		index = 0
		if err
			res.send postList
			return
		for index of out.items
			item = out.items[index]
			postList.push
				title: str(item.title).unescapeHTML().s
				timeAgo: item.time_ago
				url: item.url

		res.send postList
		return

	return