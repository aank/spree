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
  
  let(:order) { mock_model(Order, :number => "R123123", :reload => nil, :save! => true) }
  let(:line_item) { mock_model(LineItem).as_null_object }
  
  describe "GET index" do
    let(:collection) { mock("collection") }
    before { controller.stub :collection => collection }
    
    it 'should GET list of Line Items' do
      get uri_for("/line_items"), nil, user_request(@user.authentication_token)
      response.should be_success
    end
  end
  
  describe "GET show" do
    before {LineItem.stub(:new).and_return(line_item)}
    it "should GET a single Line Item" do
      get uri_for("/line_items/#{line_item.id}"), nil, user_request(@user.authentication_token)
      response.should be_success
    end
  end
  
  describe "POST create" do
    
    it "should POST new data to Line Items" do
      LineItem.should_receive(:new)
      post uri_for("/line_items"), {:line_item => {:order => order}}, user_request(@user.authentication_token)
      response.should be_success
    end
  end
  
  describe "PUT update" do
    #let(:model) { mock_model Model }
    it "should PUT updated data into Line Items" do
      pending("getting there")
      put uri_for("/line_items/#{line_item.id}"), nil, user_request(@user.authentication_token)
      response.should be_success
    end
  end
  
end
  
