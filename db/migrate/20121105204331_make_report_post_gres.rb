class MakeReportPostGres < ActiveRecord::Migration
  def change
  	create_table :reports do |t|
  		t.string :name
  	end
  end

end
