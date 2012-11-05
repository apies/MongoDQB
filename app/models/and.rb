class And < QueryDecorator
  def filters
    filters = (@queries.map {|query| query.filters}).flatten
  end
  def compose
    @filters = filters
    super
  end
end