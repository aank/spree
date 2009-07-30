class CreateCalculatorsForTaxRates < ActiveRecord::Migration
  def self.up
    TaxRate.find(:all).each do |tax_rate|
      case tax_type
      when TaxRate::TaxType::SALES_TAX
        tax_rate.calculator = Calculator::SalesTax.new
      when TaxRate::TaxType::VAT
        tax_rate.calculator = Calculator::Vat.new
      end
      tax_rate.save!
    end
  end

  def self.down
  end
end
