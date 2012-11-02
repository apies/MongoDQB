class MongoDQB.Models.ReportFilter
	constructor: ({@fieldName, @fieldOperator, @fieldValue}) ->
		
	#fieldOperators: ['>=', '<=', '=', '=!', '<', '>']
	fieldOperators: ['gt', 'gte', 'lt', 'lte', 'eq']
	#fieldNames: ['Lifetime Order Quantity', 'ZipCode', 'Last Order Date']
	fieldNames: ['fm_freight_revenue', 'fm_freight_cost', 'client_id', 'ship_date']
	
	notThat: (stuff, that) ->
		console.log 'notThat being called!'
		thing for thing in stuff when thing isnt that