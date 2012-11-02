class MongoDQB.Routers.ReportRouter extends Backbone.Router
	routes:
		'' : 'index'
		'reports/:id': 'show'
	initialize: ->
		@view = new MongoDQB.Views.AppView(collection: MongoDQB.Collections.Reports)
		@view.render()
		MongoDQB.Collections.Reports.fetch()
		@
	index: ->
		console.log 'hello index'
		@
	show: (id) ->
		report = MongoDQB.Collections.Reports.get(id)
		@view.renderReport(report)
		@