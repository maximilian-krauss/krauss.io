app = angular.module 'krauss.io', [
	'ngRoute'
	'ngAnimate'
	'angular-loading-bar'
	'nvd3ChartDirectives'
	'angulartics'
	'angulartics.google.analytics'
]

app.config [
	'$routeProvider'
	'$locationProvider',
	($routeProvider, $locationProvider) ->
		$locationProvider.html5Mode true

		partialViewRoot = "/static/html/views/"

		$routeProvider.when("/",
			title: 'Home'
			templateUrl: "#{partialViewRoot}index.html"
			controller: "IndexCtrl"
		).when("/imprint",
			title: 'Contact'
			templateUrl: "#{partialViewRoot}imprint.html"
			controller: "ImprintCtrl"
		).when("/about",
			title: 'About'
			templateUrl: "#{partialViewRoot}about.html"
			controller: "AboutCtrl"
		).when("/projects/:name",
			title: 'Project details'
			templateUrl: "#{partialViewRoot}project-detail.html"
			controller: "ProjectDetailCtrl"
		).when("/404",
			title: 'Page not found'
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
	'$location'
	'$rootScope',
	($location, $rootScope) ->
		$rootScope.title = "Maximilian Krauß"
		$rootScope.socialIcons = [
				{
					title: 'GitHub'
					icon: 'github'
					link: 'https://github.com/maximilian-krauss'
				}
				{
					title: 'Twitter'
					icon: 'twitter'
					link: 'https://twitter.com/DonnieBerlin'
				}
				{
					title: 'XING'
					icon: 'xing'
					link: 'https://www.xing.com/profile/Maximilian_Krauss6'
				}
				{
					title: 'Keybase',
					icon: 'key',
					link: 'https://keybase.io/maximilian'
				}
				{
					title: 'Mail',
					icon: 'envelope',
					link: 'mailto:max@krauss.io'
				}
		]

		$rootScope.$on('$routeChangeSuccess', (event, current, previous) ->
			$rootScope.title = if current.$$route.title? then "Maximilian Krauß - #{current.$$route.title}" else "Maximilian Krauß"
			return
			)

		return
]
