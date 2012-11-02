class MongoDQB.Views.AppMenuView extends Backbone.View
	className: 'well nav-list'
	initialize: ->
		@template = $('#navMenuView').html()
		#console.log @template
		@
	render: ->
		menuTemplate = Handlebars.compile(@template)
		$(@el).html(menuTemplate(menuHeader: 'Hello Report Navigation'))
		@delegateEvents()
		@
	addReport: ->
		report = new MongoDQB.Models.Report
		@collection.add report
		@renderReport(report)
		@
	renderReport: (report) ->
		MongoDQB.Views.reportView.close() if MongoDQB.Views.reportView
		MongoDQB.Views.reportView = new MongoDQB.Views.ReportView(model: report)
		MongoDQB.Views.reportView.render().el
		@
			
	events:
		'click .addReport': 'addReport'