class Report
  #attr_accessible :report_filters
  include Mongoid::Document
  
  embeds_many :report_filters
  accepts_nested_attributes_for :report_filters
  field :name, type: String
end
