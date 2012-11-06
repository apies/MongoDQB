require 'spec_helper'

describe "Reports", js: true do
  	describe "Main App, GET /" do
    	
    	before :all do
        report = Report.create!(:name => 'test report')
      end


      it "displays reports" do
    		#Report.create!(:name => 'test report')
    		visit root_path
      		# Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      		#save_and_open_page
      		page.should have_content("Hello Report Navigation")
    	end

    	it "can see that the server is correctly sending json from test database" do
    		visit("/api/reports.json")
    		#save_and_open_page
    		page.should have_content("[{\"id\"")
    	end

    	it "can make a new report and add some filters and save the report" do
    		visit root_path
    		click_button "Add Report"
    		#add filter button only available on report
    		page.should have_content("Add Filter")
        click_button "Add Filter"
        click_button "Add Filter"
        click_button "Add Filter"
        page.should have_content("ShowFilter")
        click_button "Save Report"
        page.should_not have_content("Add Filter")
    	end

      it "can make a new report and see the resulting morris js pie chart graph" do#
        visit root_path
        click_button "Add Report"
        click_button "Add Filter"
        #fill_in "fieldValue", :with => 1.0
        click_button "Show Report"
          page.should have_content "13,203"
        #save_and_open_page
        #page.should have_content "13,203"

      end





  	end
end
