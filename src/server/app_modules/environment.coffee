exports.get = (name) ->
	value = process.env[name]
	if value is `undefined`
		err = "Required environment variable  #{name} is not defined!"
		console.error err
		throw err
	value
