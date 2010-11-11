require 'spec_helper.rb'

describe Api::LineItemsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  before(:each) do
    @user = mock_model(User, :authentication_token => '123xxx123xxx')
    @order = mock_model(Order).as_null_object
  end
  
  let(:order) { mock_model(Order).as_null_object }
  
  describe "GET index" do
    it 'should GET list of Line Items' do
      pending("Still waiting on fabricate for implementation")
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
  
