require 'spec_helper.rb'

describe Api::ShipmentsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  before(:each) do
    @user = mock_model(User).as_null_object
    @shipment = mock_model(Shipment).as_null_object
    
    @order = mock_model(Order)
    @shipments = mock("shipments")
    @order.stub_chain(:shipments).and_return(@shipments)
    
  end

  
  context "with valid api token" do

    describe "#index" do
      it 'should GET list of Shipments' do
        get uri_for("/shipments"), nil, user_request(@user.authentication_token)
        response.should be_success
      end

      it 'should GET list of Shipments for an order' do
        puts uri_for("/orders/#{@order}/shipments")
        get uri_for("/orders/#{@order}/shipments"), nil, user_request(@user.authentication_token)
        
        last_request.url.should eql("http://example.org/api/orders/#{@order}/shipments")
        response.should be_success
      end
    end
      
    describe "#show" do
      it "should GET a single Shipment" do
        get uri_for("/shipments/#{@shipment}"), nil, user_request(@user.authentication_token)
        last_request.url.should eql("http://example.org/api/shipments/#{@shipment}")
        response.should be_success
      end
    end
    
    describe "#create" do
      before do
        Shipment.stub(:new).and_return(@shipment)
      end
      it "should POST new data to Shipments" do
        Shipment.should_receive(:new).with("order_id" => "R123123").and_return(@shipment)
        post uri_for("/shipments/#{@shipment}"), {:shipment => {:order_id => "R123123"}}, user_request(@user.authentication_token)
        
        last_request.url.should eql("http://example.org/api/shipments/#{@shipment}")
        response.should be_success
      end
    end
    
    describe "#update" do
      #let(:model) { mock_model Model }
      it "should PUT updated data into Shipments" do
        pending("Still waiting on fabricate for implementation")
        put uri_for("/orders/#{@shipment.order_id}/shipments/#{@shipment.id}"), nil, user_request(@user.authentication_token)
        
        last_request.url.should eql("http://example.org/api/orders/#{order.id}/shipments")
        response.should be_success
      end
    end
    
  end # close good context

end
  
