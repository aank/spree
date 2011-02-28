class TaxonsController < Spree::BaseController

  before_filter :load_taxon, :only => [:show]

  helper :products

  def show
    params[:taxon] = @taxon.id
    @searcher = Spree::Config.searcher_class.new(params)
    @products = @searcher.retrieve_products
  end

  private

  def accurate_title
    @taxon ? @taxon.name : nil
  end

  def load_taxon
    @taxon = Taxon.find_by_permalink!(params[:id])
  end

end
