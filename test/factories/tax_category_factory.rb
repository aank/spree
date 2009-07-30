Factory.sequence(:tax_category_sequence) {|n| "TaxCategory ##{n}"}

Factory.define(:tax_category) do |record|
  record.name { "TaxCategory - #{rand(999999)}" }
  record.description { Faker::Lorem.sentence }

  record.tax_rates {|proxy| [TaxRate.new(:amount => 0.05, :tax_type => TaxRate::TaxType::VAT, :zone => (Zone.find(:first) || Factory(:zone)))]}
end