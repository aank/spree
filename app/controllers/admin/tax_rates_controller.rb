class Admin::TaxRatesController < Admin::BaseController
  resource_controller
  before_filter :load_data
  
  update.after do
    Rails.cache.delete('vat_rates')
  end

  create.after do
    Rails.cache.delete('vat_rates')
  end
    
  private 
  
  def load_data
    @available_zones = Zone.find :all, :order => :name
    @available_categories = TaxCategory.find :all, :order => :name
    @calculators = Calculator.all_available_for(@object)
  end
end
