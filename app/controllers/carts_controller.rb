class CartsController < ApplicationController
  def add_to_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    cart = session[:cart] ||= {}
    cart[product.id.to_s] ||= 0
    cart[product.id.to_s] += quantity
    redirect_to root_path
  end

  def show
    @cart_items = Product.where(id: session[:cart]&.keys)
  end

  def remove_from_cart
    product_id = params[:product_id]
    session[:cart].delete(product_id.to_s)
    redirect_to cart_path
  end

  def update_quantity
    product_id = params[:product_id]
    new_quantity = params[:quantity].to_i
    if new_quantity > 0
      session[:cart][product_id.to_s] = new_quantity 
    else
      session[:cart].delete(product_id.to_s)
    end
    redirect_to cart_path
  end
  
end