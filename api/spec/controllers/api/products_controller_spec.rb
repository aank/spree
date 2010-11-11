require 'spec_helper.rb'

describe Api::ProductsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  @user = mock_model(User).as_null_object
  let(:product) { mock_model(Product).as_null_object }
  
  describe "GET index" do
    it 'should GET list of Products' do
      pending("Not Implemented Product#retrieve_products")
      get uri_for("/products"), nil, user_request(@user.authentication_token)

      last_request.url.should eql( uri_for("/products") )
      last_response.should be_ok
    end
    
    it 'should NOT GET list of Products' do
      pending("Not Implemented Product#retrieve_products")
      get uri_for("/products"), nil, user_request("chadisrad")

      last_request.url.should eql( uri_for("/products") )
      last_response.should_not be_ok
    end
  end
  
  describe "GET show" do
    before do
      Product.stub(:new).and_return(product)
    end
    it "should GET a single Product" do
      pending("Not Implemented Product#retrieve_products")
      get uri_for("/products/#{product.id}"), nil, user_request(@user.authentication_token)

      last_request.url.should eql( uri_for("/products/#{product.id}") )
      last_response.should be_ok

    end
  end
  
  describe "POST create" do
    
    it "should POST new data to Products" do
      pending("Not Implemented Product#retrieve_products")
      post uri_for("/products"), {params} , user_request(@user.authentication_token)
      last_request.url.should eql(uri_for("/products"))
      last_response.should be_ok
    end
  end
  
  describe "PUT update" do
    
    it "should PUT updated data into Products" do
      pending("Not Implemented Product#retrieve_products")
      put uri_for("/products/#{product.id}"), {params}, user_request(@user.authentication_token)
      
      last_request.url.should eql(uri_for("/products/#{product.id}"))
      last_response.should be_ok
    end
  end
  
end
  
