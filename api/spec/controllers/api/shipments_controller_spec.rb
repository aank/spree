require 'spec_helper.rb'

describe Api::ShipmentsController do
  include Rack::Test::Methods

  def app
    Rails.application
  end
  
  
  
  let(:order) { mock_model(Order, :number => "R123123", :reload => nil, :save! => true) }
  let(:shipment) { mock_model(Shipment).as_null_object }

  context "with good auth token" do
    
    before(:each) do
      @user = mock_model(User).as_null_object  
    end
  
    describe "#index" do
      let(:collection) { mock("collection") }
      before { controller.stub :collection => collection }
    
      it 'should GET list of Shipments' do
        get uri_for("/shipments"), nil, user_request(@user.authentication_token)
        response.should be_success
      end

    end
    
    describe "#show" do
      before {Shipment.stub(:new).and_return(shipment)}
      it "should GET a single Shipment" do
        get uri_for("/shipments/#{shipment.id}.json"), nil, user_request(@user.authentication_token)
        response.should be_success
      end
    end
  
    describe "#create" do
    
      it "should POST new data to Shipments for an Order" do
        Shipment.should_receive(:new)
        post uri_for("/shipments.json"), {:shipment => {:order => order}}, user_request(@user.authentication_token)
        response.should be_success
      end
    end
    
    describe "#update" do
      before {Shipment.stub(:new).and_return(shipment)}
      it "should PUT updated data into Shipments" do
        pending("I coming")
        Shipment.should_receive(:update)
        put uri_for("/shipments/#{shipment.id}.json"), {:shipment => {:order => order}}, user_request(@user.authentication_token)
        
        response.should be_success
      end
    end
  end
  
  context "with no auth token" do
    describe "#index" do
    
      it 'should GET list of Shipments' do
        get uri_for("/shipments.json"), nil, user_request(nil)
        last_response.status.should == 422
      end

    end
  end
  
  context "with bad auth token" do
    describe "#index" do
    
      it 'should GET list of Shipments' do
        get uri_for("/shipments.json"), nil, user_request("poopoo")
        last_response.status.should == 422
      end

    end
  end

end
  
