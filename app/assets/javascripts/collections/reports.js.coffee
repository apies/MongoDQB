class MongoDQB.Collections.ReportCollection extends Backbone.Collection
	model: MongoDQB.Models.Report
	url: '/api/reports'
	
MongoDQB.Collections.Reports = new MongoDQB.Collections.ReportCollection