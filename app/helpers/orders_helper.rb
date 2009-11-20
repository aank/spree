module OrdersHelper  
  # indicates whether user is able to claim this order
  def can_claim?(order, token)
    !order.user && token == order.token
  end
end