class OrdersController < ApplicationController
  def create
    order = Order.create
    cart = session[:cart] || {}
    
    cart.each do |product_id, quantity|
      product = Product.find(product_id)
      order.order_items.create(product: product, quantity: quantity)
    end

    session[:cart] = nil
    redirect_to root_path
  end
end