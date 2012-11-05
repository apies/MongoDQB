class ReportsController < ApplicationController
  
  respond_to :json
  
  def index
    respond_with Report.all
  end
  
  def show
    respond_with Report.find(params[:id])
  end
  
  def create
    respond_with Report.create(params[:report])
  end
  
  def update
    report = params[:report]
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
