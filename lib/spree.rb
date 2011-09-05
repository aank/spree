require 'spree_core'
require 'spree_auth'
require 'spree_api'
require 'spree_dash'
require 'spree_promo'
require 'spree_sample'

require 'generators/spree/extension/extension_generator'

module Spree
  class Engine < Rails::Engine
    engine_name 'spree'
  end
end
