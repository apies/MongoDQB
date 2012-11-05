class Query

    attr_accessor :filters

	def initialize(*filters)
		@filters = filters
	end

	def compose
		filters = aggregate_filters
		filters.inject({}){|result, filter| result.merge(filter)}
	end
  
  	def aggregate_filters
    	filters = []
    	filter_groups = @filters.group_by {|filter| filter.q_field }
    	filter_groups.each do |key, filter_group|
	      	if filter_group.count > 1
	        	composite_filter = { key => {"$#{filter_group[0].q_op}" => filter_group[0].q_value, "$#{filter_group[1].q_op}" => filter_group[1].q_value } }
	        	filters.push composite_filter
	      	else
	        	filters.push filter_group[0].compose
	      	end
    	end
    	filters
  	end


end
