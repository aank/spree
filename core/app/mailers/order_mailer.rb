class OrderMailer < ActionMailer::Base
  helper "spree/base"

  #TODO fix default email
  default :from => "sean@railsdog.com"#Spree::Config[:order_from]

  def confirm_email(order, resend=false)
    @order = order
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} Order Confirmation ##{order.number}"
    mail(:to => order.email,
         :subject => subject)
  end

  def cancel_email(order, resend=false)
    @order = order
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} Cancellation of Order ##{order.number}"
    mail(:to => order.email,
         :subject => subject)
  end
  # TODO -bcc stuff
end
