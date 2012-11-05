class MongoDQB.Views.ReportFilterView extends MongoDQB.Views.BaseAppView
	tagName: 'li'
	className: 'filterListItem'
	initialize: ->
		@template = $('#reportFilter').html()
		@
	render: ->
		filterView = Handlebars.compile(@template)
		$(@el).append(filterView(@model.toJSON()))
		@
	deleteFilter: =>
		@model.destroy(
			wait: true
			success: (model, response) ->
				console.log "#{model}:#{response}"
			error: (e) ->
				console.log e

		)
		console.log @model.destroy()
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
	