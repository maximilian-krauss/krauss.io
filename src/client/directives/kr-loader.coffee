angular.module('krauss.io.directives').directive 'krLoader', ->
	restrict: 'E'
	replace: true
	transclude: true
	template: '<div class="directive loader"><i class="fa fa-refresh fa-spin"></i> <span ng-transclude></span></div>'