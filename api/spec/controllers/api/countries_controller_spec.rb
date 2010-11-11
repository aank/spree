require 'spec_helper.rb'

describe Api::CountriesController do
  include Rack::Test::Methods

  def app
    ActionController::Dispatcher.new
  end
  
  before(:each) do
    #Factories need to be made here to lost the reliance on the model
    #person.email = "David",
    #person.authentication_token = "da1183decc246e0357060cec1cf85af89beeefee"
  end
  
  describe "GET index" do
    it 'should GET list of countries' do
      pending("Still waiting on fabricate for implementation")
      get '/api/countries', nil, { 
        'HTTP_AUTHORIZATION' => "#{authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      assert last_response.ok?
    end
  end
  
  describe "GET show" do
    it "should GET a single country" do
      pending("Still waiting on fabricate for implementation")
      get '/api/countries/:id', nil, { 
        'HTTP_AUTHORIZATION' => "#{authentication_token}:xxxxxx",
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
      assert last_response.ok?
    end
  end
  
end
  
