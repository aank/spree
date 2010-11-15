require 'spec_helper.rb'

describe Api::ShipmentsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  
  
  let(:order) { mock_model(Order, :number => "R123123", :reload => nil, :save! => true) }
  
  before(:each) do
    @user = mock_model(User).as_null_object
    @shipment = mock_model(Shipment).as_null_object
    
    #@order = mock_model(Order, :save => true)
    #Order.stub(:find).and_return(@order)
    Order.stub(:find).with(1).and_return(order) 
    @shipments = mock("shipment_proxy")
    @shipments.stub(:build).and_return(mock_model(Shipment, :save => true))
    
    order.stub(:shipments).and_return(@shipments)
    
  end
  
  describe "#index" do
    it 'should GET list of Shipments' do
      get uri_for("/shipments"), nil, user_request(@user.authentication_token)
      response.should be_success
    end

    it 'should GET list of Shipments for an order' do
      puts uri_for("/orders/#{order}/shipments")
      get uri_for("/orders/#{order}/shipments"), nil, user_request(@user.authentication_token)
      
      last_request.url.should eql("http://example.org/api/orders/#{order}/shipments")
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
    it "should POST new data to Shipments for an Order" do
      Shipment.should_receive(:new).with(:order => order)
      post uri_for("/orders/#{order}/shipments"), {:shipment => {:order => order}}, user_request(@user.authentication_token)
      
      last_request.url.should eql("http://example.org/api/shipments/#{@shipment}")
      response.should be_success
    end
  end
  #
  #describe "#update" do
  #  #let(:model) { mock_model Model }
  #  it "should PUT updated data into Shipments" do
  #    put uri_for("/orders/#{@order}/shipments/#{@shipment}"), nil, user_request(@user.authentication_token)
  #    
  #    last_request.url.should eql("http://example.org/api/orders/#{order.id}/shipments")
  #    response.should be_success
  #  end
  #end

end
  
