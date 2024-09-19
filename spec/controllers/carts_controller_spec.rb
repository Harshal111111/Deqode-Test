require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:product) { Product.create(name: "Test Product", price: 9.99) }

  describe "POST #add_to_cart" do
    it "adds the specified quantity of a product to the cart" do
      post :add_to_cart, params: { product_id: product.id, quantity: 3 }
      expect(session[:cart]).to eq({ product.id.to_s => 3 })
    end

    it "increases the quantity if the product is already in the cart" do
      session[:cart] = { product.id.to_s => 2 }
      post :add_to_cart, params: { product_id: product.id, quantity: 3 }
      expect(session[:cart]).to eq({ product.id.to_s => 5 })
    end
  end

  describe "GET #show" do
    it "assigns cart items to @cart_items" do
      session[:cart] = { product.id.to_s => 2 }
      get :show
      expect(assigns(:cart_items)).to eq([product])
    end
  end

  describe "DELETE #remove_from_cart" do
    it "removes the product from the cart" do
      session[:cart] = { product.id.to_s => 2 }
      delete :remove_from_cart, params: { product_id: product.id }
      expect(session[:cart]).to_not have_key(product.id.to_s)
    end
  end

  describe "PATCH #update_quantity" do
    it "updates the quantity of a product in the cart" do
      session[:cart] = { product.id.to_s => 2 }
      patch :update_quantity, params: { product_id: product.id, quantity: 5 }
      expect(session[:cart][product.id.to_s]).to eq(5)
    end

    it "removes the product when quantity is set to 0" do
      session[:cart] = { product.id.to_s => 2 }
      patch :update_quantity, params: { product_id: product.id, quantity: 0 }
      expect(session[:cart]).to_not have_key(product.id.to_s)
    end
  end
end