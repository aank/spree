class ThirdPartyPayment < Payment
  has_many :third_party_txns  
  alias :txns :third_party_txns
  belongs_to :order
end
