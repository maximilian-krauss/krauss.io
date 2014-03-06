angular.module('krauss.io.directives').directive "krToggler", [
	"directiveViewRoot"
	(directiveViewRoot) ->
		restrict: "E"
		replace: true
		templateUrl: "#{directiveViewRoot}kr-toggler"
		transclude: true
		scope:
			khqInline: "@"

		link: (scope, elem, attrs) ->
			scope.isHiddenContentVisible = false
			scope.khqInline = eval_(scope.khqInline)  if scope.khqInline
			scope.toggleContent = ->
				scope.isHiddenContentVisible = not scope.isHiddenContentVisible
				return

			return
]
