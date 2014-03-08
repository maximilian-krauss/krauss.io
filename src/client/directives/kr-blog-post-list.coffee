angular.module('krauss.io').directive "krBlogPostList", [
	"$http"
	"apiEndpoints"
	"directiveViewRoot"
	($http, apiEndpoints, directiveViewRoot) ->
		restrict: "E"
		replace: true
		templateUrl: "#{directiveViewRoot}kr-blog-post-list.html"
		scope: true
		link: (scope, elem, attrs) ->
			scope.isBusy = true
			scope.postList = []
			$http(
				method: "GET"
				url: apiEndpoints.getBlogPostList
			).success((data) ->
					scope.isBusy = false
					scope.postList = data
					return
			).error (data, status) ->
				console.error "Failed to fetch blog posts:  #{status}"
				return

			return
]
