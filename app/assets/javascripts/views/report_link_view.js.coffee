class MongoDQB.Views.ReportLinkView extends Backbone.View
	tagName: 'li'
	className: 'reportLink'
	initialize: ->
		@
	render: ->
		$(@el).append(HandlebarsTemplates['report_link_view'](@model.toJSON()))
		@
	showReport: ->
		console.log @model.toJSON()
		Backbone.history.navigate("reports/#{@model.get('id')}", true)
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