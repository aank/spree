class Checkout < ActiveRecord::Base  
  before_save :authorize_creditcard, :unless => "Spree::Config[:auto_capture]"
  before_save :capture_creditcard, :if => "Spree::Config[:auto_capture]"
  after_save :process_coupon_code
  after_save :update_default_shipping
  
  belongs_to :order
  belongs_to :shipping_method
  belongs_to :bill_address, :foreign_key => "bill_address_id", :class_name => "Address"
  belongs_to :ship_address, :foreign_key => "ship_address_id", :class_name => "Address"

  accepts_nested_attributes_for :ship_address, :bill_address

  # for memory-only storage of creditcard details
  attr_accessor :creditcard    
  attr_accessor :coupon_code

  private
  def authorize_creditcard
    return unless process_creditcard? 
    cc = Creditcard.new(creditcard.merge(:address => self.bill_address, :checkout => self))
    return unless cc.valid? and cc.authorize(order.total)
    order.complete
  end

  def capture_creditcard
    return unless process_creditcard? 
    cc = Creditcard.new(creditcard.merge(:address => self.bill_address, :checkout => self))
    return unless cc.valid? and cc.purchase(order.total)
    order.complete
    order.pay
  end

  def process_creditcard?
    order and creditcard and not creditcard[:number].blank?
  end

  def process_coupon_code
    return unless @coupon_code and coupon = Coupon.find_by_code(@coupon_code.upcase)
    coupon.create_discount(order)
  end

  def update_default_shipping
    order.shipment.update_attributes({
        :shipping_method => shipping_method,
        :address => ship_address
      })
  end
end
