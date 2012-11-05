class MapReduceQuery
  
  class << self 
    attr_accessor :reduce, :finalize, :map
    
    def freight_cost_avg_by_method(db, query)
      reports = db['shipment_reports'].mapreduce(@map, @reduce, {:out => { 'inline' => 1}, :raw => true , :query => query, :finalize => @finalize  })
    end
    
  end
  
  @map = %Q{
    function(){
      var shipping_method = this.ship_method_used.replace(/^\s+|\s+$/g, "").toLowerCase();
    	return emit(shipping_method,
    		{'net_charges': this.ups_info.net_charges, 'average_cost': 0, 'total_shipments': 1 }
    	);
    }
  }
  
  @reduce = %Q{
        function(key, values){
        	var net_charges = 0;
          var average_cost = 0;
          var total_shipments_sum = 0; 
        
        	values.forEach(function(value) {
        		net_charges += value.net_charges;
        		total_shipments_sum += value.total_shipments;
        	});
 	
        	return {net_charges: net_charges, 'average_cost': 0, total_shipments: total_shipments_sum};
	
        }
  }
  @finalize = %Q{
    function(key, result){
    	var average_cost = result.net_charges/result.total_shipments;
    	return { 'total_charges': result.net_charges, 'average_cost': average_cost, 'total_shipments': result.total_shipments};
    }
  }
     
  
  
  
end
