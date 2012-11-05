class ReportFiltersController < ApplicationController
  
  respond_to :json
  
  def index
    report = Report.find(params[:report_id])
    report_filters = ReportFilter.where(:report_id => params[:report_id])
    respond_with report_filters
  end
  
  def show
    respond_with ReportFilter.find(params[:id])
  end
  
  def create
    report = Report.find(params[:report_id])
    filter = params[:report_filter]
    filter[:report_id] = report.id
    #report.report_filters.build(filter)
    #report.save
    report_filter = ReportFilter.create(filter)
    #binding.pry
    respond_with(report_filter, :location => "nil")
  end
  
  def update
    #console.log params

  end
  
  def destroy
    report_filter = ReportFilter.find(params[:id])
    respond_with report_filter.delete
  end
  
  
end
