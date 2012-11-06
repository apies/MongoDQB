require 'spec_helper'

describe Query do

  	
  before :all do
    @db = Mongo::Connection.new('xmltester', 27017).db('rootpi')
    @ShipmentReports = @db['shipment_reports']
  end
  
  it "can query the database" do
    shipments = @ShipmentReports.find(:client_id => 289)
    shipments.count.should be > 1000
  end
  
  it "can use my query translator to query the datgabase" do
    filter1 = QueryFilter.new("fm_freight_revenue", "gt", 10)
    filter2 = QueryFilter.new("fm_freight_cost", "gt", 10)
    query1 = Query.new(filter1, filter2)
    reports = @ShipmentReports.find(  query1.compose )
    reports.count.should be > 10
  end
  
  it "does not get confused by duplicate keys" do
    filter1 = QueryFilter.new("fm_freight_revenue", "gte", 1)
    filter2 = QueryFilter.new("fm_freight_revenue", "lte", 100)
    filter3 = QueryFilter.new("client_id", "lte", 1000)
    query1 = Query.new(filter1, filter2, filter3)
    query1.compose["fm_freight_revenue"]["$gte"].should eq 1
    query1.compose["fm_freight_revenue"]["$lte"].should eq 100 
    reports = @ShipmentReports.find(  query1.compose   )
    reports.count.should be > 10
  end
  
  
  it "i can write an AND query joining together two queries" do
    filter1 = QueryFilter.new("fm_freight_revenue", "gt", 1)
    filter2 = QueryFilter.new("fm_freight_cost", "gt", 1)
    filter3 = QueryFilter.new("client_id", "gte", 1000)
    query1 = Query.new(filter1, filter2)
    query2 = Query.new(filter3)
    query3 = And.new(query1,query2 )
    reports = @ShipmentReports.find(  query3.compose   )
    reports.count.should be > 10 
  end
  
  it "can logically OR query result sets" do
    ups_query = Query.new(QueryFilter.new("ups_info", "exists", true),  QueryFilter.new("ship_method_used", "regex", /\w+/))
    user_query = Query.new(QueryFilter.new("ship_date", "lte", Time.utc(2012, 10, 17)))
    expensive_query = Query.new(QueryFilter.new("fm_freight_revenue", "gte", 345.56))
    composite_query = Or.new( And.new(ups_query, user_query), expensive_query)
    reports = @ShipmentReports.find(composite_query.compose)
    reports.count.should be > 10000
  end
  
  it "can run a WHERE query" do
    ups_query = Query.new(QueryFilter.new("ups_info", "exists", true))
    user_query = Query.new(QueryFilter.new("ship_date", "lte", Time.utc(2012, 10, 17)))
    expensive_query = Query.new(QueryFilter.new("fm_freight_revenue", "eq", "fm_freight_cost"))
    composite_query = Where.new( expensive_query)
    puts composite_query.compose
    #reports = @ShipmentReports.find(composite_query.compose)
    #reports.count.should be > 10000
  end
  
  
  it "I can attach a report result set to a report object for the REST interface" do
    filter1 = QueryFilter.new("fm_freight_revenue", "gt", 10)
    filter2 = QueryFilter.new("client_id", "gte", 1000)
    query1 = Query.new(filter1, filter2)
    shipment_reports = @ShipmentReports.find(  query1.compose )

    report = Report.create!(:name => 'test report')
    report_hash = JSON.parse(report.to_json)
    #turn shipments queries from mongodb into gigantic hash 
    shipments = JSON.parse(shipment_reports.to_json)
    #smash hash together with hammer
    report[:report_result_set] = shipments
    #send to client as json
    parsed_json_report = JSON.parse(report.to_json) 
    parsed_json_report["report_result_set"].count.should be > 10 
  end
  
  it "can make Jim's report about average freight cost by shipping type" do
    ups_query = Query.new(QueryFilter.new("ups_info", "exists", true))
    user_query = Query.new(QueryFilter.new("ship_method_used", "regex", /\w+/))
    composite_query = And.new(ups_query, user_query)
    reports = MapReduceQuery.freight_cost_avg_by_method(@db, composite_query.compose)
    ups_result = reports["results"].find {|result| result["_id"] == "ups ground" }
    (ups_result['value']['total_charges']/ups_result['value']['total_shipments'] ).should eq ups_result['value']['average_cost']
  end
  
  it "i can query mongo by date with ruby driver" do
    reports = @ShipmentReports.find(  {"ship_date" => {"$lte" => Time.utc(2012, 5, 1) }} )
    reports.count.should be > 10000
    date_filter = QueryFilter.new("ship_date", "lte", Time.utc(2012, 5, 1))
    more_reports = @ShipmentReports.find(date_filter.compose)
    more_reports.count.should be > 10000
  end
  
  it "can apply date range filters to Jim's report about average freight cost by shipping type" do
    ups_query = Query.new(QueryFilter.new("ups_info", "exists", true),  QueryFilter.new("ship_method_used", "regex", /\w+/))
    user_query = Query.new(QueryFilter.new("ship_date", "lte", Time.utc(2012, 10, 17)))
    composite_query = And.new(ups_query, user_query)
    puts composite_query.compose
    reports = MapReduceQuery.freight_cost_avg_by_method(@db, composite_query.compose)
    
    ups_result = reports["results"].find {|result| result["_id"] == "ups ground" }
    (ups_result['value']['total_charges']/ups_result['value']['total_shipments'] ).should eq ups_result['value']['average_cost']
  end
  
  it "can send $where clause to mongo with ruby driver" do
    reports = @ShipmentReports.find(  {"$where" => 'this.fm_freight_revenue > this.fm_freight_cost', "client_id" => 289}  )
    puts reports.count
    reports.count.should be > 2
  end
  
  
end
