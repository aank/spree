ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end

I18n.locale = "en-US"

ActionController::TestCase.class_eval do
  # special overload methods for "global"/nested params
  [ :get, :post, :put, :delete ].each do |overloaded_method|
    define_method overloaded_method do |*args|
      action,params,extras = *args
      super action, params || {}, *extras unless @params
      super action, @params.merge( params || {} ), *extras if @params
    end
  end
end  

def setup
  super
  @params = {}
end

class TestCouponCalc
  def self.calculate_discount(checkout)    
    0.99
  end
end

def create_order_with_items
  @order = Factory(:order)
  3.times do
    variant = Factory(:product).variants.first
    Factory(:line_item, :variant => variant, :order => @order)
  end
  
  @order.line_items.reload
  @order.update_totals
end

def create_shipping_method_for(order)
  @checkout = order.checkout
  @shipping_method = Factory(:shipping_method)
  @checkout.shipping_method = @shipping_method
  @checkout.ship_address = Factory(:address)
  @checkout.bill_address = Factory(:address)
  @checkout.save
  @order.reload
end