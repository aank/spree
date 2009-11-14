class PaymentsController < Spree::BaseController
  skip_before_filter :verify_authenticity_token      
  
  resource_controller
  belongs_to :order
  
  create.before :pend_payment, :prevent_fake_payment

  private
  def prevent_fake_payment
    # Do not allow users to create meaningful payments (amount should be set by follow up transaction after verification)
    @payment.amount = 0
  end
  def pend_payment
    @order.pend_payment if @order.can_pend_payment?
  end
end
