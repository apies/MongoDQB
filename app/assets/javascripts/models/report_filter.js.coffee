class MongoDQB.Models.ReportFilter extends Backbone.Model
	urlRoot:() ->
		if @get('_id')
			"/api/reports/#{@get('report_id')}/report_filters/"
		else
			"/api/filters/"

	#constructor: ({@fieldName, @fieldOperator, @fieldValue}) ->
	defaults:
		fieldOperators: ['gt', 'gte', 'lt', 'lte', 'eq']
		fieldNames: ['fm_freight_revenue', 'fm_freight_cost', 'client_id', 'ship_date']
		fieldValue: 'fm_freight_cost'
		fieldOperator: 'gte'
		fieldValue: '3.14'
		
		
	
	#fieldOperators: ['gt', 'gte', 'lt', 'lte', 'eq']

	#fieldNames: ['fm_freight_revenue', 'fm_freight_cost', 'client_id', 'ship_date']
	
	notThat: (stuff, that) ->
		console.log 'notThat being called!'
		thing for thing in stuff when thing isnt that
		
		
