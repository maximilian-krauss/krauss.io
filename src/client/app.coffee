app = angular.module 'krauss.io', [
	'ngRoute'
	'ngAnimate'
	'angular-loading-bar'
	'nvd3ChartDirectives'
]

app.config [
	'$routeProvider'
	'$locationProvider',
	($routeProvider, $locationProvider) ->
		$locationProvider.html5Mode true

		partialViewRoot = "/static/html/views/"

		$routeProvider.when("/",
			templateUrl: "#{partialViewRoot}index.html"
			controller: "IndexCtrl"
		).when("/imprint",
			templateUrl: "#{partialViewRoot}imprint.html"
			controller: "ImprintCtrl"
		).when("/about",
			templateUrl: "#{partialViewRoot}about.html"
			controller: "AboutCtrl"
		).when("/projects/:name",
			templateUrl: "#{partialViewRoot}project-detail.html"
			controller: "ProjectDetailCtrl"
		).when("/404",
			templateUrl: "#{partialViewRoot}http404.html"
			controller: "Http404Ctrl"
		).otherwise redirectTo: "/404"

		return
]

app.config [
	"cfpLoadingBarProvider"
	(cfpLoadingBarProvider) ->
		cfpLoadingBarProvider.includeSpinner = false;
		return
]

app.run [
	'$rootScope',
	($rootScope) ->
		return
]
