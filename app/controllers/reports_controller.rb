class ReportsController < ApplicationController
  
  respond_to :json
  
  def index
    respond_with Report.all
  end
  
  def show
    report = Report.find(params[:id])

    query_filters = report.report_filters.map {|filter| QueryFilter.new(filter.fieldName, filter.fieldOperator, filter.fieldValue) }

    user_query = Query.new(*query_filters)
    
    @db = Mongo::Connection.new('xmltester', 27017).db('rootpi')

    
    #applying new logic block here in order to hook map reduce into query
    ups_query = Query.new(QueryFilter.new("ups_info", "exists", true), QueryFilter.new("ship_method_used", "regex", /\w+/)   )
    composite_query = And.new(user_query, ups_query)
    
    #dirty debugging
    puts composite_query.compose
    
    shipment_reports = MapReduceQuery.freight_cost_avg_by_method(@db, composite_query.compose)

    #binding.pry

    report_hash = JSON.parse(report.to_json)

    shipments_reports_hash = JSON.parse(shipment_reports.to_json)

    

    report_hash[:report_result_set] = shipments_reports_hash

    #binding.pry

    respond_with report_hash


  end
  
  def create
    respond_with Report.create(params[:report])
  end
  
  def update
    report = params[:report]
    db_report = Report.find params[:id]
    db_report.update_attributes(report)
    respond_with db_report
  end
  
  def destroy
    report = Report.find(params[:id])
    respond_with report.delete
  end
  
  
end
