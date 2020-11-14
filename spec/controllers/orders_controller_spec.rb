require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:property) { create(:property, category: category) }
  let!(:product) { create(:product, category: category, price: 99) }
  let!(:other_product) { create(:product, category: category, price: 10) }
  let!(:product_properties) { create_list(:product_property, 3, product: product, property: property) }
  let!(:other_product_properties) { create_list(:product_property, 3, product: other_product, property: property) }
  let!(:cart) { create(:cart, user: user) }
  let!(:cart_item) { create(:cart_item, product: product, cart: cart) }
  let!(:other_cart_item) { create(:cart_item, product: other_product, cart: cart) }

  before do
    cart_item.product_properties << product_properties.first
    other_cart_item.product_properties << other_product_properties.first
  end

  describe 'GET #new' do
    it 'redirects to new view' do
      get :new, params: {cart_id: cart}
      expect(response).to render_template(:new)
    end

    it 'assigns new order to variable' do
      get :new, params: {cart_id: cart}
      expect(assigns(:order)).to be_a_new(Order)
    end

    it 'add calculated price to variable' do
      get :new, params: {cart_id: cart}
      expect(assigns(:order).price).to eq 109
    end

    it 'add generated items_list to variable' do
      get :new, params: {cart_id: cart}
      items_list = "#{product.price}$ - #{product.name} (#{product_properties.first.value})\n#{other_product.price}$ - #{other_product.name} (#{other_product_properties.first.value})"
      expect(assigns(:order).items_list).to eq items_list
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates new record in database' do
        expect { post :create, params: {order: attributes_for(:order), cart_id: cart} }.to change(Order, :count).by(1)
      end

      it 'redirects to root path' do
        post :create, params: {order: attributes_for(:order), cart_id: cart}
        expect(response).to redirect_to root_path
      end

    end

    context 'with invalid attributes' do
      it 're-renders new view' do
        post :create, params: {order: attributes_for(:order, :no_full_name), cart_id: cart}
        expect(response).to render_template :new
      end

      it 'does not create new record in database' do
        expect do
          post :create, params: {order: attributes_for(:order, :no_full_name), cart_id: cart}
        end.to_not change(Order, :count)
      end
    end
  end
end