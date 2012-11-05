require 'spec_helper'

describe Query do


	describe "Value Caster" do
    
	    it "can cast datestrings to dates" do
	      filter = QueryFilter.new("ship_date", "gte", "01/17/1984")
	      filter.q_value.class.should eq Time
	    end
	  
	    it "can cast regexp to regex" do
	      filter = QueryFilter.new("ship_date", "gte", %Q{/\w+\d{3}/})
	      filter.q_value.class.should eq Regexp
	    end
	    
	    it "can keep strings as strings" do
	      filter = QueryFilter.new("fm_freight_revenue", "eq", "fm_freight_cost")
	      filter.q_value.class.should eq String
	    end
	    
	    it "can cast integers as integers" do
	      filter = QueryFilter.new("person_value", "eq", "123132123")
	      #puts filter.q_value
	      filter.q_value.class.should eq Fixnum
	    end
	    
	    it "can cast floats as floats" do
	      filter = QueryFilter.new("person_value", "eq", "12313.2123")
	      filter.q_value.class.should eq Float
	    end
	    
	    it "can translate equal clauses to => hashes" do
	      filter = QueryFilter.new("fm_freight_revenue", "eq", 123)
	      puts filter.compose
	      filter.compose["fm_freight_revenue"].should eq 123
	    end
    
  end
end

