class OrdersController < ApplicationController
  def create
    cart = session[:cart] || {}

    if cart.empty?
      redirect_to root_path, alert: 'Your cart is empty.'
      return
    end

    order = Order.new
    products = Product.where(id: cart.keys)

    products.each do |product|
      quantity = cart[product.id.to_s]
      order.order_items.build(product: product, quantity: quantity)
    end

    if order.save
      session[:cart] = nil
      redirect_to root_path, notice: 'Order successfully placed.'
    else
      redirect_to root_path, alert: 'Order could not be created.'
    end
  end
end
