angular.module('krauss.io').directive "krMarkdown", [
	"$http"
	($http) ->
		restrict: "E"
		replace: true
		scope:
			khqSrc: "="
		link: (scope, elem, attrs) ->
			converter = new Showdown.converter()
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
