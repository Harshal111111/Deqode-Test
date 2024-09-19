require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all products to @products" do
      product = Product.create(name: "Test Product", price: 99)
      get :index
      expect(assigns(:products)).to eq([product])
    end

    it "assigns the cart from session to @cart" do
      session[:cart] = { "1" => 2, "2" => 3 }
      get :index
      expect(assigns(:cart)).to eq({ "1" => 2, "2" => 3 })
    end

    it "assigns an empty hash to @cart if session[:cart] is nil" do
      get :index
      expect(assigns(:cart)).to eq({})
    end
  end
end