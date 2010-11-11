require 'spec_helper.rb'

describe Api::ShipmentsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  before(:each) do
    @user = mock_model(User, :authentication_token => '123xxx123xxx')
    @order = mock_model(Order)
    @shipment = mock_model(Shipment, :order_id => mock_model(Order)).as_null_object
    #Shipment.stub_chain(:order_id, :id).and_return(@shipment)
  end
  #let(:user) { mock_model User, :authentication_token => '123xxx123xxx' }
  #let(:shipment) { mock_model(Shipment).as_null_object }
  # The below is failing, why? 
  
  
  describe "GET index" do

    context "list only shipments" do
      it 'should GET list of Shipments' do
        get "/api/shipments", nil, { 
          'HTTP_AUTHORIZATION' => "#{@user.authentication_token}:xxxxxx",
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
      
        last_request.url.should eql("http://example.org/api/shipments")
        last_response.should be_ok
      end
    end
    
    context "list shipments of an Order" do
      it 'should GET list of Shipments' do
        get "/api/orders/#{@shipment.order_id}/shipments", nil, { 
          'HTTP_AUTHORIZATION' => "#{@user.authentication_token}:xxxxxx",
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
      
        last_request.url.should eql("http://example.org/api/orders/#{@shipment.order_id}/shipments")
        last_response.should be_ok
      end
    end
    
  end
  
  context "GET show" do
    
    it "should GET a single Shipment" do
      get "/api/orders/#{@shipment.order_id}/shipments/#{@shipment.id}", nil, { 
        'HTTP_AUTHORIZATION' => "#{@user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/orders/#{@shipment.order_id}/shipments/#{@shipment.id}")
      last_response.should be_ok
    end
  end
  
  context "POST create" do
    #let(:model) { mock_model Model }
    it "should POST new data to Shipments" do
      pending("Still waiting on fabricate for implementation")
      post '/api/shipments/', nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/orders/#{order.number}/shipments")
      last_response.should be_ok
    end
  end
  
  context "PUT update" do
    #let(:model) { mock_model Model }
    it "should PUT updated data into Shipments" do
      pending("Still waiting on fabricate for implementation")
      put "/api/orders/#{order.id}/shipments", nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/orders/#{order.id}/shipments")
      last_response.should be_ok
    end
  end
  
end
  
