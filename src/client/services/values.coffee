angular.module('krauss.io')
	.value("appVersion", "0.1")
	.value("partialViewRoot", "/static/html/views/")
	.value("directiveViewRoot", "/static/html/directives/")
	.value("apiEndpoints",
		getProjectList: "/api/projects"
		getProjectDetail: "/api/project"
		getProjectReporting: "/api/reports"
		getBlogPostList: "/api/blog/latest"
		getTeaserImage: "/api/teaser-image?l="
		getRawTeaserImage: "/api/raw-teaser-image?l="
		getGithubInfo: "/api/github")
