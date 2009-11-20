require 'test_helper'

class OrdersHelperTest < ActionView::TestCase
  context "order w/out user" do
    setup do 
      @order = create_complete_order
      @order.update_attribute("user_id", nil)
    end
    should "allow user to claim w/valid token" do
      assert can_claim?(@order, @order.token)
    end    
    should "not allow user to claim w/valid token" do
      assert !can_claim?(@order, "BOGUS")
    end    
  end
  context "order w/user" do
    setup { @order = create_complete_order }
    should "not allow user to claim" do
      assert !can_claim?(@order, @order.token)
    end    
  end
end