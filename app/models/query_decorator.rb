class QueryDecorator < Query
  #extend Forwardable
  attr_accessor :queries
  def initialize(*queries)
    @queries = queries
  end
end