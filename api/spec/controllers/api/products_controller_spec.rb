require 'spec_helper.rb'

describe Api::ProductsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  before(:each) do
    @user = mock_model(User).as_null_object
    @product = mock_model(Product).as_null_object
  end
  
  context "when valid api token" do
    
    describe "#index" do
      it 'should GET list of Products' do
        pending("Not Implemented Product#retrieve_products")
        get uri_for("/products"), nil, user_request(@user.authentication_token)

        last_request.url.should eql( uri_for("/products") )
        last_response.should be_ok
      end
    end 
    describe "#show" do
      before do
        Product.stub(:id => "R123123")
      end
      
      it "#show" do
        pending("Not Implemented Product#retrieve_products")
        get uri_for("/products/#{product.id}"), nil, user_request(@user.authentication_token)

        last_request.url.should eql( uri_for("/products/#{product.id}") )
        last_response.should be_ok

      end
    end
    
    describe "#create" do

      it "should POST new data to Products" do
        pending("Not Implemented Product#retrieve_products")
        post uri_for("/products"), nil , user_request(@user.authentication_token)
        last_request.url.should eql(uri_for("/products"))
        last_response.should be_ok
      end
    end

    describe "#update" do

      it "should PUT updated data into Products" do
        pending("Not Implemented Product#retrieve_products")
        put uri_for("/products/#{product.id}"), nil, user_request(@user.authentication_token)

        last_request.url.should eql(uri_for("/products/#{product.id}"))
        last_response.should be_ok
      end
    end
    
  end
      
  context "when no valid api token" do  
    describe "#index" do
      it 'should NOT GET list of Products' do
        pending("Not Implemented Product#retrieve_products")
        get uri_for("/products"), nil, user_request("chadisrad")

        last_request.url.should eql( uri_for("/products") )
        last_response.should_not be_ok
      end
    end
    
    describe "#show" do
      before do
        Product.stub(:id => "R123123")
      end
      
      it "should NOT show anything" do
        pending("Not Implemented Product#retrieve_products")
        get uri_for("/products/#{product.id}"), nil, user_request(@user.authentication_token)

        last_request.url.should eql( uri_for("/products/#{product.id}") )
        last_response.should be_ok

      end
    end
    
    describe "#create" do

      it "should POST new data to Products" do
        pending("Not Implemented Product#retrieve_products")
        post uri_for("/products"), nil , user_request(@user.authentication_token)
        last_request.url.should eql(uri_for("/products"))
        last_response.should be_ok
      end
    end

    describe "#update" do

      it "should PUT updated data into Products" do
        pending("Not Implemented Product#retrieve_products")
        put uri_for("/products/#{product.id}"), nil, user_request(@user.authentication_token)

        last_request.url.should eql(uri_for("/products/#{product.id}"))
        last_response.should be_ok
      end
    end
  end
  
end
  
