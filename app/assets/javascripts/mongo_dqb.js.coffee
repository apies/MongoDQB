window.MongoDQB =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	init: ->
		new MongoDQB.Routers.ReportRouter()
		Backbone.history.start(pushState: true)

$(document).ready ->
	MongoDQB.init()
