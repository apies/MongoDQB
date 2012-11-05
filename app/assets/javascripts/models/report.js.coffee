class MongoDQB.Models.Report extends Backbone.Model
	idAttribute: "_id"
	urlRoot: '/api/reports'
	toJSON: ->
		report = _.extend(@attributes )
	defaults:
		name: 'Most Awesome Report Ever'
		#report_filters: []
		
	addFilter: (fName = 'fm_freight_cost', fOperator = 'gte', fValue='1') ->
		filter = new MongoDQB.Models.ReportFilter(fieldName: fName, fieldOperator: fOperator, fieldValue: fValue, report_id: @get('_id'))
		@add( 'report_filters', filter )
		@
		
	#validate: (attributes) ->
		#clone attributes so can see original as well as new attributes for validation
		#mergedAttributes = _.extend(_.clone(@attributes), attributes)
		#if not attributes.name or attributes.name.trim() == ''
			#return "Report name must not be blank!"
		
MongoDQB.Models.AppObserver = {}
_.extend(MongoDQB.Models.AppObserver, Backbone.Events)
MongoDQB.Models.AppObserver.on("saveReport", ->
	console.log("Observer Firing!")
	MongoDQB.Collections.Reports.fetch()
)	
	