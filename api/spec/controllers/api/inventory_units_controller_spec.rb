require 'spec_helper.rb'

describe Api::InventoryUnitsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  let(:inventory_unit) { mock_model(InventoryUnit).as_null_object }
  
  context "With a good token" do
    
    before(:each) do
     @user = mock_model(User).as_null_object
    end
    
    describe "GET index" do
    
      let(:collection) { mock("collection") }
      before { controller.stub :collection => collection }

      it 'should GET list of Inventory Units' do
        get uri_for("/inventory_units.json"), nil, user_request(@user.authentication_token)
        response.should be_success
      end
    end
      
    describe "GET show" do
      before {InventoryUnit.stub(:new).and_return(inventory_unit)}
      
      it "should GET a single Inventory Unit" do
        get uri_for("/inventory_units/#{inventory_unit.id}.json"), nil, user_request(@user.authentication_token)
        response.should be_success
      end
    end

    describe "POST create" do
      
      it "should POST new data to Inventory Units" do
        post uri_for("/api/inventory_units.json"), {:text => {:foo => "text"}}, user_request(@user.authentication_token)
        response.should be_success
      end
    end

    describe "PUT update" do
      before do
        InventoryUnit.stub(:find).and_return(inventory_unit)
      end
      it "should PUT updated data into Inventory Units" do
        pending("The find and update pain - I'll get it on the rebound")
        put uri_for("/inventory_units/#{inventory_unit.id}.json"), {:text => {:foo => "text"}}, user_request(@user.authentication_token)
        response.should be_success
      end
    end
    
  end

  context "with no auth token" do
    describe "GET index" do
      it 'should not GET list of Inventory Units (no auth_token)' do
        get uri_for("/inventory_units.json"), nil, user_request(nil)
        last_response.status.should == 422
      end
    end
  end
    
  context "with a bad auth token" do
    describe "GET index" do
      it 'should not GET list of Inventory Units (bad auth_token)' do
        get uri_for("/inventory_units.json"), nil, user_request("poopoo")
        last_response.status.should == 422
      end
    end
  end
      
end
  