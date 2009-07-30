class TaxRate < ActiveRecord::Base
  belongs_to :zone
  belongs_to :tax_category
  has_calculator

  named_scope :by_zone, lambda { |zone| { :conditions => ["zone_id = ?", zone] } }

  enumerable_constant :tax_type, :constants => [:sales_tax, :vat]

  def calculate_tax(order)
    calculator.compute(order)
  end

  def before_create
    case tax_type
    when TaxRate::TaxType::SALES_TAX
      self.calculator = Calculator::SalesTax.new
    when TaxRate::TaxType::VAT
      self.calculator = Calculator::Vat.new
    end
  end
end
