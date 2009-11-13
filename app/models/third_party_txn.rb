class ThirdPartyTxn < ActiveRecord::Base
  belongs_to :third_party_payment
  validates_numericality_of :amount
end
