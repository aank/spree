class Calculator::Tax < Calculator
  def self.description
    "Special calculator for taxes"
  end

  def self.available?(object)
    object.is_a?(Order)
  end

  # Computes a vat and sales tax for _order_ based on tax rates associated with zones
  def compute(order = nil)
    return unless order.ship_address

    zones = Zone.match(order.ship_address.zone)
    tax_rates = zones.map{|zone| zone.tax_rates}.flatten.uniq
    # Right now we search all zones for matching addresses that results in tons of queries
    # (i've noticed possible O(n!) on zones, let's hope users don't create to much,
    # also there seems to be possibility to kill application creating looped zones).
    # alternative implementation, that checks only for one related zone has drawback
    # of not finding tax_rates that are hooked to "parent zones".
    #
    # return unless order.ship_address && order.ship_address.zone
    # tax_rates = order.ship_address.zone.tax_rates

    tax_rates.map{|tax_rate| tax_rate.calculate_tax(order)}
  end
end