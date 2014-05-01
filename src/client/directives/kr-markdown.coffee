angular.module('krauss.io').directive "krMarkdown", [
	"$http"
	($http) ->
		restrict: "E"
		replace: true
		scope:
			khqSrc: "="
		link: (scope, elem, attrs) ->
			converter = new Showdown.converter()

			elem.html converter.makeHtml(elem.text()) if elem.text().length > 0

			scope.$watch "khqSrc", (newValue) ->
				return if newValue is `undefined`
				
				$http.get(newValue).success (markdown) ->
					elem.html converter.makeHtml(markdown)
					return

				return

			return
]
