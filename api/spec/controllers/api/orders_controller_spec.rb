require 'spec_helper.rb'

describe Api::OrdersController do
  include Rack::Test::Methods

  def app
    Rails.application 
  end

  before(:each) do
    @user = mock_model(User).as_null_object
    @order = mock_model(Order).as_null_object
    #Order.stub!(:new, :user_id => @user.id).and_return(@order)
  end
  
  describe "GET index" do
    #before(:each) do
    #  
    #end
    
    it "should NOT GET list of orders" do
       get uri_for("/orders"), nil, user_request("chadisrad")
        
        last_request.url.should eql( uri_for("/orders") )
        last_response.should_not be_ok
    end
    
    it 'should GET list of orders' do
      get uri_for("/orders"), nil, user_request(@user.authentication_token)
      
      last_request.url.should eql( uri_for("/orders") )
      last_response.should be_ok
    end
    
  end
    
  describe "GET show" do
    
    it "should GET a single order" do
      get uri_for("/orders/#{@order.number}"), nil, user_request(@user.authentication_token)
      
      last_request.url.should eql( uri_for("/orders/#{@order.number}") )
      last_response.should be_ok
    end
    
  end

  
end
