class Where < And 
  def compose
    composed_query = super
    query = {"$where" => composed_query}
  end
end