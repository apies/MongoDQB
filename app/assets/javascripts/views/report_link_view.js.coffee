class MongoDQB.Views.ReportLinkView extends Backbone.View
	tagName: 'li'
	className: 'reportLink'
	initialize: ->
		@template = $('#reportLink').html()
		@
	render: ->
		reportLink = Handlebars.compile(@template)
		$(@el).append(reportLink(@model.toJSON()))
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