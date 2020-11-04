require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:admin) { create(:user, admin: true) }
  let(:category) { create(:category) }
  let(:products) { create_list(:product, 3, category: category) }

  describe 'GET #index' do
    before { get :index }

    it 'populates array of all products' do
      expect(assigns(:products)).to match_array(products)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    context 'by admin' do
      before { login(admin) }
      before { get :new, params: { category_id: category } }

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'by guest' do
      before { get :new, params: { category_id: category } }

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'by admin' do
      before { login(admin) }
      context 'with valid attributes' do
        it 'creates new record in database' do
          expect do
            post :create, params: {category_id: category, product: {name: 'Test product name', category_id: category.id}}
          end.to change(Product, :count).by(1)
        end

        it 'renders show view' do
          post :create, params: {category_id: category, product: { name: 'Test product name', category_id: category.id } }
          expect(response).to redirect_to category_path(category)
        end
      end

      context 'with invalid attributes' do
        it 're-renders new view' do
          post :create, params: {category_id: category, product: {name: '', category_id: category.id}}
          expect(response).to render_template :new
        end

        it 'does not create new record in database' do
          expect do
            post :create, params: {category_id: category, product: {name: '', category_id: category.id}}
          end.to_not change(Product, :count)
        end
      end
    end

    context 'by guest' do
      before { post :create, params: {category_id: category, product: attributes_for(:product)} }

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: products.first } }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end