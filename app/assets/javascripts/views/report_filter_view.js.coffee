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
	events: ->
		'click .remove_filter': 'deleteFilter'
	