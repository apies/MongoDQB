class MongoDQB.Views.ReportFilterView extends Backbone.View
	tagName: 'li'
	className: 'filterListItem'
	initialize: ->
		@template = $('#reportFilter').html()
		@
	render: ->
		filterView = Handlebars.compile(@template)
		$(@el).append(filterView(@model.toJSON()))
		@
	showReport: ->
		Backbone.history.navigate("reports/#{@model.get('_id')}", true)
		$('.reportLink').removeClass("active")
		$(@el).addClass("active")
		@
	deleteReport: =>
		@model.destroy()
		@unbind()
		@remove()
		@
	events: ->
		'click .showReport': 'showReport'
		'click .remove_report': 'deleteReport'
	