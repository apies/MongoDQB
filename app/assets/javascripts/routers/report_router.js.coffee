class MongoDQB.Routers.ReportRouter extends Backbone.Router
	routes:
		'' : 'index'
		'reports/:id': 'show'
	initialize: ->
		MongoDQB.Views.appView = new MongoDQB.Views.AppView(collection: MongoDQB.Collections.Reports)
		MongoDQB.Views.appView.render()
		MongoDQB.Collections.Reports.fetch()
		@
	index: ->
		console.log 'hello index'
		@
	show: (id) ->
		report = MongoDQB.Collections.Reports.get(id)
		MongoDQB.Views.appView.renderReport(report)
		@