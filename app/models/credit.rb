class Credit < Charge
   before_save :inverse_amount

  def inverse_amount
    x = self.amount > 0 ? -1 : 1
    self.amount = self.amount * x
  end

  def calculate_charge
    charge = super
    charge && (
      x = charge > 0 ? -1 : 1
      charge * x
    )
  end
end
