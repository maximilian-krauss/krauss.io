kraussIOControllers = angular.module "krauss.io.controllers", [
	"ngRoute"
	"krauss.io.services"
	"krauss.io.directives"
]

kraussIOControllers.config [
	"$routeProvider",
	($routeProvider) ->
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
