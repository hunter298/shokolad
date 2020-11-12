require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:properties) { create_list(:property, 2, category: category) }
    let(:product) { create(:product, category: category) }
    let(:other_product) { create(:product, category: category) }
    let(:product_property) { create(:product_property, product: product, property: properties.first) }
    let(:other_product_property) { create(:product_property, product: product, property: properties.last) }

    context 'by authenticated user' do

    end

    context 'by guest' do
      it 'creates new entry in database', js: true do
        expect { post :create, params: {product_id: product}, format: :json }.to change(CartItem, :count).by(1)
      end

      it 'creates new cart with cookies attribute', js: true do
        expect { post :create, params: {product_id: product}, format: :json }.to change(Cart, :count).by(1)
        expect(Cart.last.cookies).to_not be_nil
        expect(Cart.last.user_id).to be_nil
      end

      it 'add cart items to cart', js: true do
        post :create, params: {product_id: product}, format: :json
        post :create, params: {product_id: product}, format: :json
        expect(Cart.last.cart_items.count).to eq 2
      end

      it 'add chosen product properties to associations collection of cart item', js: true do
        post :create,
             params: {product_id: product, properties: [product_property.id, other_product_property.id]},
            format: :json
        expect(CartItem.last.product_properties).to match_array [product_property, other_product_property]
      end
    end

    context 'by user' do
      before do
        login(user)
      end

      it 'creates new entry in database' do
        expect { post :create, params: {product_id: product}, format: :json }.to change(CartItem, :count).by(1)
      end

      it 'creates new cart with user_id attribute' do
        expect { post :create, params: {product_id: product}, format: :json }.to change(Cart, :count).by(1)
        expect(Cart.last.user_id).to_not be_nil
        expect(Cart.last.cookies).to be_nil
      end

      it 'add cart items to cart' do
        post :create, params: {product_id: product}, format: :json
        post :create, params: {product_id: product}, format: :json
        expect(Cart.last.cart_items.count).to eq 2
      end

      it 'add chosen product properties to associations collection of cart item' do
        post :create,
             params: {product_id: product, properties: [product_property.id, other_product_property.id]},
             format: :json
        expect(CartItem.last.product_properties).to match_array [product_property, other_product_property]
      end
    end
  end
end