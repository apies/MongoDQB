class MongoDQB.Models.ReportFilter extends Backbone.Model
	idAttribute: "_id"
	urlRoot: ->
		"/api/reports/#{@get('report_id')}/report_filters"

	toJSON: ->
		filter = _.extend(@attributes )

	defaults:
		fieldOperators: ['gt', 'gte', 'lt', 'lte', 'eq']
		fieldNames: ['fm_freight_revenue', 'fm_freight_cost', 'client_id', 'ship_date']
		fieldName: 'fm_freight_cost'
		fieldOperator: 'gte'
		fieldValue: '3.14'
		
		
		
