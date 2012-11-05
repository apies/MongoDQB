class MongoDQB.Views.AppView extends Backbone.View
	el: $('#wrap')
	initialize: ->
		@el = $('#wrap')
		@subviews = [
			new MongoDQB.Views.AppMenuView collection: @collection
			new MongoDQB.Views.ReportCatalogView collection: @collection
		]
		@collection.bind 'reset', @render, @
		@
	render: ->
		console.log 'app view rendering'
		$(@el).empty()
		$(@el).append subview.render().el for subview in @subviews
		$('#currentReport').remove()
		$('body').append('<div id="currentReport" class="well"></div>')
		@delegateEvents()
		@
			
	renderReport: (report) ->
		MongoDQB.Views.reportView.close() if MongoDQB.Views.reportView
		MongoDQB.Views.reportView = new MongoDQB.Views.ReportView(model: report)
		MongoDQB.Views.reportView.render().el
		@
