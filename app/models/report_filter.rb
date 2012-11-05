class ReportFilter < ActiveRecord::Base
	attr_accessible :fieldOperator, :fieldValue, :fieldName
  	belongs_to :report
end
