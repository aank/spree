require 'spec_helper.rb'

describe Api::ProductsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  let(:user) { mock_model User, :authentication_token => '123xxx123xxx' }
  let(:product) { mock_model(Product).as_null_object }
  
  describe "GET index" do
    it 'should GET list of Products' do
      pending("Not Implemented Product#retrieve_products")
      get '/api/products', nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/products")
      last_response.should be_ok
    end
  end
  
  describe "GET show" do
    before do
      Product.stub(:new).and_return(product)
    end
    it "should GET a single Product" do
      pending("Not Implemented Product#retrieve_products")
      get "/api/products/#{product.id}'", nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/products/#{product.id}")
      last_response.should be_ok
    end
  end
  
  describe "POST create" do
    
    it "should POST new data to Products" do
      pending("Not Implemented Product#retrieve_products")
      post '/api/products/', nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/products")
      last_response.should be_ok
    end
  end
  
  describe "PUT update" do
    
    it "should PUT updated data into Products" do
      pending("Not Implemented Product#retrieve_products")
      put '/api/products/:id', nil, { 
        'HTTP_AUTHORIZATION' => "#{user.authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      last_request.url.should eql("http://example.org/api/products")
      last_response.should be_ok
    end
  end
  
end
  
