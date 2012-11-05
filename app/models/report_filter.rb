class ReportFilter
  include Mongoid::Document
  field :fieldOperator, type: String
  field :fieldValue, type: String
  field :fieldName, type: String
  #embedded_in :report
  belongs_to :report
end
