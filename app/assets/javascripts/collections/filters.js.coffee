class MongoDQB.Collections.ReportFilters extends Backbone.Collection
	model: MongoDQB.Models.ReportFilter
		
	#url: ->
	#	firstFilter = @at(0)
	#	unless firstFilter
	#		return '/api/filters'
	#	reportId = firstModel.get('report_id')
	#	"/api/reports/#{reportId}/filters"
	
	#initialize: (options) ->
	#	options || options
	#	super
	#	@url = 
	