class Report < ActiveRecord::Base
	attr_accessible :name
  	has_many :report_filters
end
