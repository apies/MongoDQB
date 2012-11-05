class ReportsController < ApplicationController
  
  respond_to :json
  
  def index
    respond_with Report.all
  end
  
  def show
    respond_with Report.find(params[:id])
  end
  
  def create
    #report = Report.create(params[:report])
    #report_filters = params[:report_filters]
    #report.build.report_filters(report_filters)
    #report[:report_filters] = report_filters
    respond_with Report.create(params[:report])
  end
  
  def update
    #console.log params
    report = params[:report]
    #report_filters = params[:report_filters]
    #report[:report_filters] = report_filters
    #save shipments to seperate variable for reattaching before passing back to client
    #shipments = report["report_result_set"]
    #report.delete("report_result_set")
    db_report = Report.find report[:_id]
    report.delete(:_id)
    db_report.update_attributes(report)
    respond_with db_report
  end
  
  def destroy
    report = Report.find(params[:id])
    respond_with report.delete
  end
  
  
end
