class MongoDQB.Views.ReportFilterView extends MongoDQB.Views.BaseAppView
	tagName: 'li'
	className: 'filterListItem'
	initialize: ->
		#@template = HandlebarsTemplates['report_filter'](context) #$('#reportFilter').html()
		@
	render: ->
		$(@el).append(HandlebarsTemplates['report_filter'](@model.toJSON()))
		@
	deleteFilter: =>
		#@model.destroy(
		#	wait: true
		#	success: (model, response) ->
		#		console.log "#{model}:#{response}"
		#	error: (e) ->
		#		console.log e

		#)
		@model.destroy()
		@unbind()
		@remove()
		@

	viewBindInputs: ->
		super
		@model.save()
		@
	events: ->
		'click .remove_filter': 'deleteFilter'
		'change :input' : 'viewBindInputs'
	