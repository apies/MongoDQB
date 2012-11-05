class Report
  #attr_accessible :report_filters
  include Mongoid::Document
  
  #embeds_many :report_filters
  has_many :report_filters, autosave: true
  accepts_nested_attributes_for :report_filters
  field :name, type: String
end
