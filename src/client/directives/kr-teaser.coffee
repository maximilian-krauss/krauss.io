angular.module('krauss.io.directives').directive 'krTeaser', [
	'$http'
	'$route'
	'$location'
	'$q'
	'apiEndpoints'
	'directiveViewRoot'
	($http, $route, $location, $q, apiEndpoints, directiveViewRoot) ->
		restrict: "E"
		replace: true
		templateUrl: "#{directiveViewRoot}kr-teaser.html"
		scope: true
		link: (scope, elem, attrs) ->
			scope.teaserStyle = "background-image": ""
			cancellationToken = $q.defer()
			console.log apiEndpoints.getRawTeaserImage + $location.path()
			getTeaserImageForLocation = ->
				$http(
					method: "GET"
					url: apiEndpoints.getRawTeaserImage + $location.path()
					timeout: cancellationToken
				).success((image) ->
					scope.teaserStyle["background-image"] = "url(data:image/jpg;base64,#{image.data})"
					return
				).error ->
					scope.teaserStyle["background-image"] = ""
					return

				return

			scope.$on "$routeChangeStart", (next, current) ->
				cancellationToken.resolve()
				cancellationToken = $q.defer()
				getTeaserImageForLocation()
				return

			getTeaserImageForLocation()
			return
]