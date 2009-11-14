require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  context "order in progress" do
    setup do
      @order = Factory.create(:order)
      @params = { :order_id => @order.number }
    end
    context "post" do 
      setup { post :create }
      should "set order state to payment_pending" do
        assert_equal "payment_pending", assigns(:order).state
      end
    end
    context "post with a spoofed amount value" do 
      setup do 
        @params[:payment] = {:amount => 100}
        post :create
      end
      should "not allow arbitrary payment amounts" do
        assert_equal BigDecimal("0"), assigns(:payment).amount
      end
    end
  end
end
