require 'spec_helper.rb'

describe Api::InventoryUnitsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  let(:user) { mock_model User, :authentication_token => '123xxx123xxx' }
  let(:inventory_unit) { mock_model(InventoryUnit).as_null_object }
  
  describe "GET index" do
    it 'should GET list of Inventory Units' do
      get '/api/inventory_units', nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/inventory_units")
      last_response.should be_ok
    end
  end
  
  describe "GET show" do
    before do
      InventoryUnit.stub(:new).and_return(inventory_unit)
    end
    it "should GET a single Inventory Unit" do
      get "/api/inventory_units/#{inventory_unit.id}", nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/inventory_units/#{inventory_unit.id}")
      last_response.should be_ok
    end
  end
  
  describe "POST create" do
    #let(:model) { mock_model Model }
    it "should POST new data to Inventory Units" do
      pending("Still waiting on fabricate for implementation")
      post '/api/inventory_units/', nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/inventory_units.json")
      last_response.should be_ok
    end
  end
  
  describe "PUT update" do
    #let(:model) { mock_model Model }
    it "should PUT updated data into Inventory Units" do
      pending("Still waiting on fabricate for implementation")
      put '/api/inventory_units/:id', nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/inventory_units.json")
      last_response.should be_ok
    end
  end
    
end
  
