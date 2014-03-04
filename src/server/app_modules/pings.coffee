_       = require("underscore")
config  = require("../config")
moment  = require("moment")
Q       = require("q")
http    = require("http")

buildRequests = (dayOffset, projectId) ->
	requestOptions = []
	offset = 0
	offset
	while offset < dayOffset
		requestOptions.push
			date: moment().add("day", -1).add("day", offset * -1).format("YYYY-MM-DD")
			projectId: projectId
			request:
				host: config.reporting.host
				path: "/" + [
					config.reporting.path
					moment().add("day", -1).add("day", offset * -1).format("DD_MM_YYYY") + ".json"
				].join("/")

		offset++
	requestOptions

processData = (rawData, options) ->
	dataPoints = rawData.split("\r\n")
	pings = 0
	_(dataPoints).each (rawDataPoint) ->
		return  if rawDataPoint.length is 0
		dataPoint = JSON.parse(rawDataPoint)
		pings++  if dataPoint.app.toLowerCase() is options.projectId
		return

	appPings: pings

fetchDailyPing = (options) ->
	requestOptions = _.clone(options)
	deferred = Q.defer()
	responseCallback = (response) ->
		dataBuffer = ""
		response.on "data", (chunk) ->
			dataBuffer += chunk
			return

		response.on "end", ->
			if response.statusCode >= 400
				if response.statusCode is 404
					deferred.resolve
						date: options.date
						data:
							appPings: 0

				else
					deferred.reject response.statusCode
			else
				deferred.resolve
					date: options.date
					data: processData(dataBuffer, options)

			return

		return

	request = http.get(requestOptions.request, responseCallback)
	request.on "error", (error) ->
		deferred.reject error
		return

	deferred.promise

module.exports.appReport = (projectId, successCallback, errorCallback) ->
	requestOptions = buildRequests(14, projectId)
	tasks = []
	raiseIfAssigned = (ev, argument) ->
		ev argument  if ev and typeof ev is "function"
		return

	_(requestOptions).each (option) ->
		tasks.push fetchDailyPing(option)
		return

	Q.all(tasks).then ((results) ->
		raiseIfAssigned successCallback, results
		return
	), (err) ->
		raiseIfAssigned errorCallback, err
		return

	return
