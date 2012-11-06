class Report < ActiveRecord::Base
	attr_accessible :name, :report_result_set
	attr_accessor :report_result_set
  	has_many :report_filters, :dependent => :delete_all
end
