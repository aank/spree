require 'test_helper'

class ShippingMethodTest < ActiveSupport::TestCase
  context "instance" do
    setup do 
      create_compleate_order
    end
    context "when calculator indicates method is supported" do
      should "be available" do
        assert(@zone.include?(@order.shipment.address), "Zone doesn't include address")
        assert(@shipping_method.calculator)
        assert @shipping_method.available?(@order)
      end
      context "when the shipping address falls within the method's zone" do
        should "return the amount as calculated by the method's calculator" do
          assert_not_nil(@order.shipment.calculate_shipping)
          assert_equal "10.0", @order.shipment.calculate_shipping.to_s
        end      
      end
    end
  end                 
end