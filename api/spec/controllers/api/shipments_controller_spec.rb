require 'spec_helper.rb'

describe Api::ShipmentsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  before(:each) do
    @user = mock_model(User).as_null_object
    assigns[:order] = mock_order
    assigns[:shipment] = mock_shipment
    mock_shipment.stub(:order).and_return([mock_order])
  end

  
  context "with valid api token" do

    describe "#index" do
      it 'should GET list of Shipments' do
        get uri_for("/shipments"), nil, user_request(@user.authentication_token)
        response.should be_success
      end
    end
    
    describe "#index" do
      it 'should GET list of Shipments' do
        puts uri_for("/orders/#{@order.id}/shipments")
        get uri_for("/orders/#{@order.id}/shipments"), nil, user_request(@user.authentication_token)
        
        last_request.url.should eql("http://example.org/api/orders/#{@order.id}/shipments")
        response.should be_success
      end
    end
      
    describe "#show" do
      it "should GET a single Shipment" do
        get uri_for("/orders/#{@mock_order.shipment.id}/shipments/#{@mock_shipment}"), nil, user_request(@user.authentication_token)
        last_request.url.should eql("http://example.org/api/orders/#{@mock_order.shipment.id}/shipments/#{@mock_shipment}")
        response.should be_success
      end
    end
    
    describe "#create" do
      #let(:model) { mock_model Model }
      it "should POST new data to Shipments" do
        pending("Still waiting on fabricate for implementation")
        post uri_for("/orders/#{order.shipment}/shipments/#{shipment}"), nil, user_request(@user.authentication_token)
        
        last_request.url.should eql("http://example.org/api/orders/#{order.shipment}/shipments/#{shipment}")
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

  protected
  
  def mock_shipment
    @mock_shipment ||= mock_model(Shipment, {
      :order_id => [mock_order]
    })
  end

  def mock_order
    @mock_order ||= mock_model(Order)
  end

  def mock_new_order
    @mock_new_order ||= mock_model(Order, :null_object => true).as_new_record
  end
  
end
  
