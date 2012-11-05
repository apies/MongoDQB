window.MongoDQB =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	init: ->
		MongoDQB.Routers.appRouter = new MongoDQB.Routers.ReportRouter()
		Backbone.history.start(pushState: true)

$(document).ready ->
	MongoDQB.init()
