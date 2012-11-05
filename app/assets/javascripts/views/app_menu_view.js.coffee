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
		MongoDQB.Views.appView.renderReport(report)
		@
			
	events:
		'click .addReport': 'addReport'