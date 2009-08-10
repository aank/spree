# PRODUCTS
# Products represent an entity for sale in a store.  
# Products can have variations, called variants 
# Products properties include description, permalink, availability, 
#   shipping category, etc. that do not change by variant.
#
# MASTER VARIANT 
# Every product has one master variant, which stores master price and sku, size and weight, etc.
# The master variant does not have option values associated with it.
# Price, SKU, size, weight, etc. are all delegated to the master variant.
#
# VARIANTS
# All variants can access the product properties directly (via reverse delegation).
# Inventory units are tied to Variant.
# The master variant can have inventory units, but not option values.
# All other variants have option values and may have inventory units.
# 
class Product < ActiveRecord::Base
  after_update :adjust_inventory
  after_create :set_initial_inventory
  
  has_many :product_option_types, :dependent => :destroy
  has_many :option_types, :through => :product_option_types
  has_many :variants, :dependent => :destroy
  has_many :product_properties, :dependent => :destroy, :attributes => true
  has_many :properties, :through => :product_properties
	has_many :images, :as => :viewable, :order => :position, :dependent => :destroy
	
  belongs_to :tax_category
  has_and_belongs_to_many :taxons
  belongs_to :shipping_category
  
  has_one :master, 
    :class_name => 'Variant', 
    :conditions => ["is_master = ?", true], 
    :dependent => :destroy
  delegate_belongs_to :master
  after_create :set_master_variant_defaults

  has_many :variants, 
    :conditions => ["is_master = ?", false], 
    :dependent => :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :product_properties
  
  make_permalink

  alias :options :product_option_types

  # default product scope only lists available and non-deleted products
  named_scope :active,      lambda { |*args| Product.not_deleted.available(args.first).scope(:find) }

  named_scope :not_deleted,                  { :conditions => "products.deleted_at is null" }
  named_scope :available,   lambda { |*args| { :conditions => ["products.available_on <= ?", args.first || Time.zone.now] } }

  named_scope :master_price_between, lambda {|low,high| 
    { :conditions => ["master_price BETWEEN ? AND ?", low, high] }
  }

  named_scope :taxons_id_in_tree, lambda {|taxon| 
    Product.taxons_id_in_tree_any(taxon).scope :find 
  }

  # TODO - speed test on nest vs join
  named_scope :taxons_id_in_tree_any, lambda {|*taxons| 
    taxons = [taxons].flatten
    { :conditions => [ "products.id in (select product_id from products_taxons where taxon_id in (?))", 
                       taxons.map    {|i| i.is_a?(Taxon) ? i : Taxon.find(i)}.
                              reject {|t| t.nil?}.
                              map    {|t| [t] + t.descendents}.flatten ]}
  }

  # a simple test for product with a certain property-value pairing
  # it can't test for NULLs and can't be cascaded - see :with_property 
  named_scope :with_property_value, lambda { |property, value| 
    Product.product_properties_property_id_equals(property).
            product_properties_value_equals(value).
            scope :find
  }   # coded this way to demonstrate composition


  # a scope which sets up later testing on the values of a given property
  # it takes * a property (object or id), and 
  #          * an optional distinguishing name to support multiple property tests 
  # this version includes results for which the property is not given (ie is NULL),
  #   eg an unspecified colour would come out as a NULL.
  # it probably won't be used without taxon or other filters having narrowed the set 
  #   to a point where results aren't swamped by nulls, hence no inner join version
  named_scope :with_property,
    lambda {|property,*args|
      name = args.empty? ? "product_properties" : args.first
      property_id = case property
                      when Property then property.id 
                      when Fixnum   then property
                    end
      return {} if property_id.nil?
      { :joins => "left outer join product_properties #{name} on products.id = #{name}.product_id and #{name}.property_id = #{property_id}"}
    }
                     

  # add in option_values_variants to the query
  # this is the common info required for all options searches
  named_scope :with_variant_options,
    Product.
      scoped(:joins => :variants).
      scoped(:joins => "join option_values_variants on variants.id = option_values_variants.variant_id").
      scope(:find)

  # select products which have an option of the given type
  # this sets up testing on specific option values, eg colour = red
  # the optional argument supports filtering by multi options, eg colour = red and 
  #   size = small, which need separate joins if done a property at a time
  # this version discards products which don't have the given option (the outer join
  #   version is a bit more complex because we need to control the order of joins)
  # TODO: speed test on nest vs join
  named_scope :with_option,
    lambda {|opt_type,*args|
      name   = args.empty? ? "option_types" : args.first
      opt_id = case opt_type
                 when OptionType then opt_type.id 
                 when Fixnum     then opt_type
               end
      return {} if opt_id.nil?
      Product.with_variant_options.
              scoped(:joins => "join (select presentation, id from option_values where option_type_id = #{opt_id}) #{name} on #{name}.id = option_values_variants.option_value_id").
              scope(:find)
    }


  def to_param       
    return permalink unless permalink.blank?
    name.to_url
  end
  
  # returns true if the product has any variants (the master variant is not a member of the variants array)
  def has_variants?
    !variants.empty?
  end

  # Pseduo Attribute.  Products don't really have inventory - variants do.  We want to make the variant stuff transparent
  # in the simple cases, however, so we pretend like we're setting the inventory of the product when in fact, we're really 
  # changing the inventory of the master variant.
  def on_hand
    master.on_hand
  end

  def on_hand=(quantity)
    @quantity = quantity
  end
  
  def has_stock?
    variants.inject(false){ |tf, v| tf ||= v.in_stock }
  end

  # Adding properties and option types on creation based on a chosen prototype
  
  attr_reader :prototype_id
  def prototype_id=(value)
    @prototype_id = value.to_i
  end
  after_create :add_properties_and_option_types_from_prototype
  
  def add_properties_and_option_types_from_prototype
    if prototype_id and prototype = Prototype.find_by_id(prototype_id)
      prototype.properties.each do |property|
        product_properties.create(:property => property)
      end
      self.option_types = prototype.option_types
    end
  end
  
  private
  
    def set_master_variant_defaults
      self.is_master = true
    end
  
    def adjust_inventory
      return if self.new_record?
      return unless @quantity && @quantity.is_integer?    
      new_level = @quantity.to_i
      # don't allow negative on_hand inventory
      return if new_level < 0
      master.save
      master.inventory_units.with_state("backordered").each{|iu|
        if new_level > 0
          iu.fill_backorder
          new_level = new_level - 1
        end
        break if new_level < 1
        }
      
      adjustment = new_level - on_hand
      if adjustment > 0
        InventoryUnit.create_on_hand(master, adjustment)
        reload
      elsif adjustment < 0
        InventoryUnit.destroy_on_hand(master, adjustment.abs)
        reload
      end      
    end
  
    def set_initial_inventory
      return unless @quantity && @quantity.is_integer?    
      master.save
      level = @quantity.to_i
      InventoryUnit.create_on_hand(master, level)
      reload
    end
end
