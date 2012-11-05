class MakeReportFiltersPostgres < ActiveRecord::Migration
  def change
  	create_table :report_filters do |t|
  		t.string :fieldOperator
  		t.string :fieldName
  		t.string :fieldValue
  		t.belongs_to :report
  	end
  end
end
