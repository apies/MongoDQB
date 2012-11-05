class QueryFilter

	attr_accessor :q_field, :q_op, :q_val
  	
  	def initialize(q_field, q_op, q_val)
    	@q_field = q_field
    	@q_op = q_op
    	@q_val = q_val
    	@int_match = /\A\d+\z/
    	@date_match = /\A(\d{2})\/(\d{2})\/(\d{4})\z/
    	@string_match = /\A[^\/]\w+[^\/]\z/i
    	@regex_match = /\A\/(.+)\/\z/
    	@float_match = /\A\d+\.\d+\z/
  	end
  
	def compose
		{ @q_field => {"$#{@q_op}" => q_val_string_cast(@q_val)} }
	end


	def q_value
		q_val_string_cast(@q_val)
	end
  
  	def q_val_string_cast(string)
    	return string unless string.is_a?(String)
    	case string
    	when @date_match
    		result =  Time.utc(string.match(@date_match)[3].to_i, string.match(@date_match)[1].to_i, string.match(@date_match)[2].to_i)
    	when @int_match
      		result = string.to_i
    	when @float_match
      		result = string.to_f
    	when @string_match
      		result = string.match(@string_match)[0]
    	when @regex_match
      		result = eval(string)
    	end
  	end
  
  
end
