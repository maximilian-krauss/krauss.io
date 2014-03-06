angular.module('krauss.io.controllers').controller "ProjectDetailCtrl", [
	"$scope"
	"$routeParams"
	"$http"
	"$q"
	"$location"
	"apiEndpoints"
	($scope, $routeParams, $http, $q, $location, apiEndpoints) ->
		$scope.isBusy = true
		$scope.isChartReady = false
		$scope.project = {}
		$scope.githubInfo =
			stargazers: 0
			forks: 0

		$scope.averagePingbacksPerDay = 0
		$scope.initialize = ->
			fetchProjectInfo().then ((result) ->
				$scope.project = result
				$scope.isBusy = false
				return
			), ->
				$location.path "/404"
				return

			fetchGithubInfo().then (result) ->
				$scope.githubInfo = result
				return

			fetchAppReporting().then(calculateReportingAverage).then ->
				$scope.isChartReady = true
				return

			return

		fetchProjectInfo = ->
			deferred = $q.defer()
			$http.get([
				apiEndpoints.getProjectDetail
				$routeParams.name
			].join("/")).success((projectData) ->
				deferred.resolve projectData
				return
			).error ->
				deferred.reject()
				return

			deferred.promise

		fetchGithubInfo = ->
			deferred = $q.defer()
			$http.get([
				apiEndpoints.getGithubInfo
				$routeParams.name
			].join("/")).success((data) ->
				deferred.resolve data
				return
			).error ->
				deferred.reject()
				return

			deferred.promise

		fetchAppReporting = ->
			index = 0
			dataPoints = []
			deferred = $q.defer()
			$http.get([
				apiEndpoints.getProjectReporting
				$routeParams.name
			].join("/")).success((data) ->
				for index of data
					dataPoint = data[index]
					dataPoints.push [
						moment(dataPoint.date).toDate().getTime()
						dataPoint.data.appPings
					]
				$scope.reportingData = [
					key: "Pingbacks"
					values: dataPoints
				]
				deferred.resolve()
				return
			).error ->
				deferred.reject()
				return

			deferred.promise

		calculateReportingAverage = ->
			deferred = $q.defer()
			index = 0
			totalPings = 0
			for index of $scope.reportingData[0].values
				totalPings += $scope.reportingData[0].values[index][1]
			$scope.averagePingbacksPerDay = (totalPings / $scope.reportingData[0].values.length).toFixed(0)
			deferred.resolve()
			deferred.promise

		$scope.xAxisTickFormat = ->
			(d) ->
				d3.time.format("%Y-%m-%d") new Date(d)

		return
]
