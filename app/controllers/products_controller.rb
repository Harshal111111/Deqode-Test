class ProductsController < ApplicationController
  def index
    @products = Product.all
    @cart = session[:cart] || {}

  end
end