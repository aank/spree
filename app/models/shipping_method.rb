class ShippingMethod < ActiveRecord::Base
  belongs_to :zone
  has_many :shipping_rates

  has_calculator
   
  def calculate_cost(shipment)
    shipment.calculate_shipping
  end   
  
  def available?(order)
    zone.include?(order.shipment.address) &&
      calculator
  end
end
