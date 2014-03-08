angular.module('krauss.io').directive "krMarkdown", [
	"$http"
	($http) ->
	converter = new Showdown.converter()
	restrict: "E"
	replace: true
	scope:
		khqSrc: "="

	link: (scope, elem, attrs) ->
		scope.$watch "khqSrc", (newValue) ->
			if newValue is `undefined`
				elem.html ""
				return
			$http.get(newValue).success (markdown) ->
				elem.html converter.makeHtml(markdown)
				return

			return

		return
]
