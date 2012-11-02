class Report
  include Mongoid::Document
  embeds_many :report_filters
  field :name, type: String
end
