class ReportFiltersController < ApplicationController
  
  respond_to :json
  
  def index
    report = Report.find(params[:report_id])
    #binding.pry
    report_filters = report.report_filters
    respond_with report_filters
  end
  
  def show
    respond_with ReportFilter.find(params[:id])
  end
  
  def create
    report = Report.find(params[:report_id])
    filter = report.report_filters.build(params[:report_filter])
    report.save
    respond_with(filter, :location => nil)
  end
  
  def update
    report_filter = params[:report_filter]
    db_filter = ReportFilter.find params[:id]
    #report_filter.delete(:_id)
    db_filter.update_attributes(report_filter)
    #binding.pry
    respond_with(db_filter, :location => nil)

  end
  
  def destroy
    report_filter = ReportFilter.find(params[:id])
    respond_with report_filter.delete
  end
  
  
end
