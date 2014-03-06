angular.module('krauss.io.directives').directive "krProjectList", [
	"$http"
	"apiEndpoints"
	"directiveViewRoot"
	($http, apiEndpoints, directiveViewRoot) ->
		restrict: "E"
		replace: true
		templateUrl: "#{directiveViewRoot}kr-project-list.html"
		scope: true
		link: (scope, elem, attrs) ->
			scope.isBusy = true
			scope.projectList = []
			$http(
				method: "GET"
				url: apiEndpoints.getProjectList
				).success (projects) ->
					scope.projectList = projects
					scope.isBusy = false
					return

			return
]
