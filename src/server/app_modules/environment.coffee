exports.get = (name) ->
	value = process.env[name]
	if not value?
		return null
	value
