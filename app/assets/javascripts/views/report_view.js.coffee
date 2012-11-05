class MongoDQB.Views.ReportView extends Backbone.View
	el: '#currentReport'
	className: 'well'
	initialize: ->
		@template = $('#reportView').html()
		@currentFilterCollection = new MongoDQB.Collections.ReportFilters
		@currentFilterCollection.url = "/api/reports/#{@model.get('_id')}/report_filters"
		@currentFilterCollection.on('all', @render, @)
		@currentFilterCollection.fetch() unless @model.isNew() #@currentFilterCollection.models.length is 0
		@
	render: ->
		reportTemplate = Handlebars.compile(@template)
		$(@el).html(reportTemplate(@model.toJSON()))
		@currentFilterCollection.each(@renderFilter)
		#if @model.toJSON()["report_result_set"] and not $('svg').length 
		#	results = @model.toJSON()["report_result_set"]["results"]
		#	@renderDonut(results)
		@
		
	renderFilter:  (filter) ->
		filTemplate = Handlebars.compile(@filterTemplate)
		filterView = new MongoDQB.Views.ReportFilterView(model: filter)
		$('#currentFilters').append(filterView.render().el)
		@
			
	saveReport: =>
		@model.save(
			@model.attributes
			success: (record) =>
				MongoDQB.Models.AppObserver.trigger('saveReport')
				Backbone.history.navigate("", {trigger:true, replace:true})
				@close()
			error: (model, error) =>
				@showError(model, error)
		)
		@
			
			
	viewBindInputs: (e) =>
		newKey = $(e.target).attr('name')
		newVal = $(e.target).val()
		@model.set(newKey, newVal)
		@
		
			
	addFilter: ->
		unless @model.isNew()
			@currentFilterCollection.create(report_id: @model.get('_id'))

		else
			@model.save(
				success: ->
					console.log 'Saving Model from addFilter function'
					attributes = report_id: @model.get('_id')
					@currentFilterCollection.create( attributes,
						success: ->
							console.log 'SAVED DURING REPORT CREATION'
						error: ->
							console.log "error during report creation reportfilter save"
					)
				error: (model, error) =>
					@showError(model, error)
			)
		@

	close: =>
		@unbind()
		@remove()
		$('#currentReport').remove()
		$('body').append('<div id="currentReport" class="well"></div>') 


	renderDonut: (results) ->
		donut_result = []
		donut_result.push { label: result["_id"], value: result["value"]["total_shipments"] } for result in results
		Morris.Donut(
			element: 'result-donut'
			data: donut_result
		)
		@
			
		
	showReport: ->
		@model.fetch(
			success: (result) =>
				results = result.toJSON()["report_result_set"]["results"]
				@renderDonut(results)
			error: (e) ->
				console.log e
		)
		@

	showError: (model, error) ->
		console.log "error!!!: #{JSON.stringify(error)}"
		$('#error_holder').empty()
		$('#error_holder').append("<span class='label label-important label-large' style='font-size:14pt;'>#{error}</span>")
		@
			
			
	events:
		'click .addFilter': 'addFilter'
		'change input.reportName' : 'viewBindInputs'
		'click .saveReport': 'saveReport'
		'click .showReport': 'showReport'
