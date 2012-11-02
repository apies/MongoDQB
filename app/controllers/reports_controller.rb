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
    respond_with Report.update(params[:id], params[:entry])
  end
  
  def destroy
    respond_with Report.destroy(params[:id])
  end
  
  
end
