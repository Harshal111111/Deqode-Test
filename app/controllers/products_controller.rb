class ProductsController < ApplicationController
  def index
    @products = Product.order(created_at: :desc)
    @cart = session[:cart] ||= {}
  end
end
