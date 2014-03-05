kraussIOServices = angular.module "krauss.io.services", []

kraussIOServices.value "appVersion", "0.1"

kraussIOServices.value "partialViewRoot", "/static/html/views/"
kraussIOServices.value "directiveViewRoot", "/static/html/directives/"

kraussIOServices.value "apiEndpoints",
	getProjectList: "/api/projects"
	getProjectDetail: "/api/project"
	getProjectReporting: "/api/reports"
	getBlogPostList: "/api/blog/latest"
	getTeaserImage: "/api/teaser-image?l="
	getRawTeaserImage: "/api/raw-teaser-image?l="
	getGithubInfo: "/api/github"