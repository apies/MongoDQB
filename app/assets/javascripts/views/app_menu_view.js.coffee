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
		report.save(
			report.attributes
			success: (model) =>
				console.log 'creation success!'
				@collection.add(model)
				Backbone.history.navigate("reports/#{model.get('_id')}", true)
			error: (msg) ->
				console.log msg

		)
		@
			
	events:
		'click .addReport': 'addReport'