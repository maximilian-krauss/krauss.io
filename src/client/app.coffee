app = angular.module 'krauss.io', [
	'krauss.io.controllers',
	'krauss.io.directives'
]

app.config [
	'$routeProvider',
	'$locationProvider',
	($routeProvider, $locationProvider) ->
		return
]