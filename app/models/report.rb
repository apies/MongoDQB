class Report < ActiveRecord::Base
	attr_accessible :name
  	has_many :report_filters, :dependent => :delete_all
end
