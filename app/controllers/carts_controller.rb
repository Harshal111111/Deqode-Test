class CartsController < ApplicationController
  before_action :load_cart, only: %i[add_to_cart remove_from_cart update_quantity]

  def add_to_cart
    product = Product.find_by(id: params[:product_id])
    if product
      quantity = params[:quantity].to_i
      @cart[product.id.to_s] = (@cart[product.id.to_s] || 0) + quantity
      session[:cart] = @cart
      redirect_to root_path, notice: 'Product added to cart.'
    else
      redirect_to root_path, alert: 'Product not found.'
    end
  end

  def show
    @cart_items = Product.where(id: session[:cart]&.keys)
    @cart_items_with_quantity = @cart_items.map do |product|
      { product: product, quantity: session[:cart][product.id.to_s].to_i }
    end
  end

  def remove_from_cart
    if @cart.delete(params[:product_id])
      session[:cart] = @cart
      redirect_to cart_path, notice: 'Product removed from cart.'
    else
      redirect_to cart_path, alert: 'Product not found in cart.'
    end
  end

  def update_quantity
    product_id = params[:product_id].to_s
    new_quantity = params[:quantity].to_i

    if @cart.key?(product_id)
      if new_quantity > 0
        @cart[product_id] = new_quantity
        session[:cart] = @cart
        redirect_to cart_path, notice: 'Quantity updated.'
      else
        @cart.delete(product_id)
        session[:cart] = @cart
        redirect_to cart_path, notice: 'Product removed from cart.'
      end
    else
      redirect_to cart_path, alert: 'Product not found in cart.'
    end
  end

  private

  def load_cart
    @cart = session[:cart] ||= {}
  end
end
