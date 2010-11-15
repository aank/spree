require 'spec_helper.rb'

describe Api::LineItemsController do
  # using this to simutanitously test routes
  include Rack::Test::Methods
  
  before(:each) do
    @user = mock_model(User).as_null_object
    @order = Order.stub(:number => "R123123")
  end
  
  def app
    Rails.application 
  end
  
  let(:order) { mock_model(Order).as_null_object }
  
  describe "GET index" do
    it 'should GET list of Line Items' do
      get '/api/line_items', nil, { 
        'HTTP_AUTHORIZATION' => "#{authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      assert last_response.ok?
    end
  end
  
  describe "GET show" do
    #let(:model) { mock_model Model }
    it "should GET a single Line Item" do
      pending("Still waiting on fabricate for implementation")
      get '/api/line_items/:id', nil, { 
        'HTTP_AUTHORIZATION' => "#{authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      assert last_response.ok?
    end
  end
  
  describe "POST create" do
    #let(:model) { mock_model Model }
    it "should POST new data to Line Items" do
      pending("Still waiting on fabricate for implementation")
      post '/api/line_items/', nil, { 
        'HTTP_AUTHORIZATION' => "#{authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      assert last_response.ok?
    end
  end
  
  describe "PUT update" do
    #let(:model) { mock_model Model }
    it "should PUT updated data into Line Items" do
      pending("Still waiting on fabricate for implementation")
      put '/api/line_items/:id', nil, { 
        'HTTP_AUTHORIZATION' => "#{authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      assert last_response.ok?
    end
  end
  
end
  
