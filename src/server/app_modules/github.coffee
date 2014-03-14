config	= require("../config")
env		= require("./environment")
https 	= require("https")

buildRequest = (projectId) ->

	#Env. Variable GITHUB_ACCESS_TOKEN is not stored here. It's injected by heroku. Check heroku config --app krauss-io
	githubToken = env.get "GITHUB_ACCESS_TOKEN"

	request =
		headers:
			accept: "*/*"
			"user-agent": config.github.username
		host: config.github.apiHost
		port: 443
		path: "/" + ["repos", config.github.username, projectId].join "/"

	if githubToken?
		request.headers.authorization = "Basic " + new Buffer(githubToken + ":x-oauth-basic").toString("base64")

	request

buildRepositoryData = (rawData) ->
	repoInformation = JSON.parse(rawData)
	stargazers: repoInformation.stargazers_count
	forks: repoInformation.forks_count


#
# * repoDetails - fetches repository details from Github.
# * ========================================
# * Params:
# *  projectId: Github repository name (should exists)
# *  successCallback: Raised if the request succeeds
# *  errorCallback: Raised if something screws up
#
exports.repoDetails = (projectId, successCallback, errorCallback) ->
	raiseIfAssigned = (ev, argument) ->
		ev argument  if ev and typeof ev is "function"
		return

	responseCallback = (response) ->
		dataBuffer = ""
		response.on "data", (chunk) ->
			dataBuffer += chunk
			return

		response.on "end", ->
			if response.statusCode isnt 200
				err = "GitHub request failed with status http code " + response.statusCode
				console.error err
				raiseIfAssigned errorCallback, err
			raiseIfAssigned successCallback, buildRepositoryData(dataBuffer)
			return

		return

	request = https.get(buildRequest(projectId), responseCallback)
	request.on "error", (error) ->
		err = "GitHub request failed: " + error
		console.error err
		raiseIfAssigned errorCallback, err
		return

	return
