class Or < And

	def compose
    	composed_queries = @queries.map {|query| query.compose}
    	query = {"$or" => composed_queries}
  	end
  
end