require 'spec_helper.rb'

describe Api::OrdersController do
  # using this to simutanitously test routes
  include Rack::Test::Methods
  
  before(:each) do
    @user = create_user
    @user.ensure_authentication_token!
    @order = Order.stub(:number => "R123123")
  end
  
  def app
    Rails.application 
  end
  
  context "when valid api token" do
    let(:mock_unit) { mock("unit") }
    before { controller.stub :collection => [mock_unit] }
    describe "#show" do
      it "should return JSON for the specified order" do
        get uri_for("/orders/#{@order}.json"), nil, user_request(@user.authentication_token)
        response.should be_success
      end
    end
    
    describe "#index" do
      
      context "when no search params" do
        it "should return JSON for all of the orders" do
          get  uri_for("/orders.json"), nil, user_request(@user.authentication_token)
          response.should be_success
        end
      end
      
      context "when given search params" do
        it "should return JSON for the requested orders" do
          get uri_for("/orders.json?search=#{@order}"), {:search => @order}, user_request(@user.authentication_token)
          response.should be_success
        end
      end
    end
  end
  
  context "with no auth token" do
    let(:mock_unit) { mock("unit") }
    before { controller.stub :collection => [mock_unit] }
    describe "#show" do
      it "should return JSON for the specified order" do
        get uri_for("/orders/#{@order}.json"), nil, user_request(nil)
        last_response.status.should == 406
      end
    end
    
    describe "#index" do
      
      context "when no search params" do
        it "should return JSON for all of the orders" do
          get  uri_for("/orders.json"), nil, user_request(nil)
          last_response.status.should == 422
        end
      end
      
      context "when given search params" do
        it "should return JSON for the requested orders" do
          get uri_for("/orders.json?search=#{@order}"), {:search => @order}, user_request(nil)
          last_response.status.should == 422
        end
      end
    end
  end
  
  context "with bad auth token" do
    let(:mock_unit) { mock("unit") }
    before { controller.stub :collection => [mock_unit] }
    describe "#show" do
      it "should return JSON for the specified order" do
        get uri_for("/orders/#{@order}.json"), nil, user_request(@user.authentication_token.reverse)
        last_response.status.should == 406
      end
    end
    
    describe "#index" do
      
      context "when no search params" do
        it "should return JSON for all of the orders" do
          get  uri_for("/orders.json"), nil, user_request(@user.authentication_token.reverse)
          last_response.status.should == 422
        end
      end
      
      context "when given search params" do
        it "should return JSON for the requested orders" do
          get uri_for("/orders.json?search=#{@order}"), {:search => @order}, user_request(@user.authentication_token.reverse)
          last_response.status.should == 422
        end
      end
    end
  end
end

