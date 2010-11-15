require 'spec_helper.rb'

describe Api::OrdersController do
  # using this to simutanitously test routes
  include Rack::Test::Methods
  
  before(:each) do
    @user = mock_model(User).as_null_object
    @order = Order.stub(:number => "R123123")
  end
  
  def app
    Rails.application 
  end
  
  context "when valid api token" do
    
    describe "#show" do
      it "should return JSON for the specified order" do
        get uri_for("/orders/#{@order}"), nil, user_request(@user.authentication_token)
        response.should be_success
      end
    end
    
    describe "#index" do
      
      context "when no search params" do
        it "should return JSON for all of the orders" do
          get  uri_for("/orders"), nil, user_request(@user.authentication_token)
          response.should be_success
        end
      end
      
      context "when given search params" do
        it "should return JSON for the requested orders" do
          get uri_for("/orders?search=#{@order}"), {:search => @order}, user_request(@user.authentication_token)
          response.should be_success
        end
      end
    end
    
  end
    
end

