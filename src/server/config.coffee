config =
	github:
		username: "maximilian-krauss"
		apiHost: "api.github.com"

	blog:
		feedUrl: "http://blog.krauss.io/rss/"

	projects: [
		id: "winfy"
		name: "Winfy"
		description: "Spotifys missing mini player"
		teaserUrl: "/static/images/winfy-teaser.jpg"
	]
	reporting:
		host: "ping.krausshq.com"
		path: "pings"

	app:
		hostname: "krauss.io",
		teaserMap: [
			{
				location: "/imprint"
				image: "header-background-contact.jpg"
			}
			{
				location: "/projects/winfy"
				image: "winfy-teaser.jpg"
			}
		]
		fallbackTeaser: "header-background.jpg"
		graveyard: [
			{
				request: "/posts/custom-post-types-with-views"
				response: "http://blog.krauss.io/custom-post-types-for-kirby-with-views/"
			}
			{
				request: "/go/jwxwmy"
				response: "http://blog.krauss.io/custom-post-types-for-kirby-with-views/"
			}
			{
				request: "/content/03-projects/01-Winfy/setup.exe"
				response: "http://deploy.krausshq.com/winfy/setup.exe"
			}
		]

module.exports = config
