app = angular.module 'krauss.io', [
	'ngRoute'
	'ngAnimate'
	'angular-loading-bar'
	'nvd3ChartDirectives'
	'krauss.io.services'
	'krauss.io.controllers'
	'krauss.io.directives'
]

app.config [
	'$locationProvider',
	($locationProvider) ->
		$locationProvider.html5Mode true
		return
]

app.run [
	'$rootScope',
	($rootScope) ->
		console.log $rootScope
		return
]
