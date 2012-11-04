class MongoDQB.Views.ReportView extends Backbone.View
	el: '#currentReport'
	className: 'well'
	initialize: ->
		@template = $('#reportView').html()
		@filterTemplate = $('#reportFilter').html()
		@model.bind('add:report_filters', @render, @)
		@model.bind('remove:report_filters', @render, @)
		@
	render: ->
		reportTemplate = Handlebars.compile(@template)
		$(@el).html(reportTemplate(@model.toJSON()))
		currentFilters = @model.get('report_filters')
		currentFilterCollection = new MongoDQB.Collections.ReportFilters
		currentFilterCollection.url = "/api/reports/#{@model.get('_id')}/report_filters"
		console.log currentFilterCollection 
		currentFilterCollection.fetch()
		#i = 1
		#for filter in currentFilters
		#	filter = new MongoDQB.Models.ReportFilter(fieldName: filter.fieldName, fieldOperator: filter.fieldOperator, fieldValue: filter.fieldValue)
		#	filter.filterIndex = "filter#{i}"
		#	@renderFilter(filter)
		#	i += 1
		#if @model.toJSON()["report_result_set"] and not $('svg').length 
		#	results = @model.toJSON()["report_result_set"]["results"]
		#	@renderDonut(results)
		#@
		
	renderFilter:  (filter) =>
		filTemplate = Handlebars.compile(@filterTemplate)
		$('#currentFilters').append(filTemplate(filter.toJSON()))
		fieldName = $("##{filter.filterIndex}").children("select[name='fieldName']").val()
		if fieldName.match(/date/i)
			dateInput = $("##{filter.filterIndex}").children("input[name='fieldValue']")
			dateInput.datepicker()
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
			
	showError: (model, error) ->
		console.log "error!!!: #{JSON.stringify(error)}"
		$('#error_holder').empty()
		$('#error_holder').append("<span class='label label-important label-large' style='font-size:14pt;'>#{error}</span>")
		@
			
			
	close: =>
		@unbind()
		@remove()
		$('#currentReport').remove()
		$('body').append('<div id="currentReport" class="well"></div>') 
			
	deleteFilter: (e) ->
		filterIndex = parseInt($(e.target).parent().attr('id').match(/\w+(\d+)/)[1]) - 1
		console.log "deleting filter #{filterIndex}"
		@model.remove("report_filters[#{filterIndex}]")
		@
			
		
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
			
			
	nameBind: () =>
		name = $('input.reportName').val()
		@model.set('name': name)
		@
		
	viewBindFilters: (e) =>
		#view binding report name, might move out to its own method
		if e.target.id.match(/report/)
			return @nameBind()
		#source event for filter
		filterIndex = parseInt($(e.target).parent().attr('id').match(/\w+(\d+)/)[1]) - 1
		newKey = $(e.target).attr('name')
		newVal = $(e.target).val()
			
		#going to try and have date pickers for date filters
		if newVal.match(/date/i)
			dateInput = sibling for sibling in $(e.target).siblings() when $(sibling).attr('name') is 'fieldValue'
			$(dateInput).datepicker()
		else
			input = sibling for sibling in $(e.target).siblings() when $(sibling).attr('name') is 'fieldValue'
			$(input).datepicker('destroy')
			
		#build string for filter set
		filter = "report_filters[#{filterIndex}]"
		#use super fugly set mechanism
		@model.get("report_filters[#{filterIndex}]")[newKey] = newVal
		@
		
			
	addFilter: ->
		@model.addFilter()
		@
			
			
	events:
		'click .addFilter': 'addFilter'
		'change :input' : 'viewBindFilters'
		'click .saveReport': 'saveReport'
		'click .deleteFilter': 'deleteFilter'
		'click .showReport': 'showReport'
