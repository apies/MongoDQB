class ReportsController < ApplicationController
  
  respond_to :json
  
  def index
    respond_with Report.all
  end
  
  def show
    respond_with Report.find(params[:id])
  end
  
  def create
    respond_with Report.create(params[:entry])
  end
  
  def update
    #console.log params
    report = params[:report]
    puts
    puts
    puts report
    #respond_with Report.update(params[:id], params[:entry])
  end
  
  def destroy
    report = Report.find(params[:id])
    respond_with report.delete
  end
  
  
end
