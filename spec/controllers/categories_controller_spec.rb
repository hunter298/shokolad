require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user, admin: true) }

  describe 'GET #index' do
    let(:categories) { create_list(:category, 3) }

    before { get :index }

    it 'populates array of all categories' do
      expect(assigns(:categories)).to match_array(categories)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    context 'by admin' do
      before { login(user) }
      before { get :new }

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'by guest' do
      before { get :new }

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'by admin' do
      before { login(user) }
      context 'with valid attributes' do
        it 'creates new record in database' do
          expect { post :create, params: {category: attributes_for(:category)} }.to change(Category, :count).by(1)
        end

        it 'renders show view' do
          post :create, params: {category: attributes_for(:category)}
          expect(response).to redirect_to categories_path
        end
      end

      context 'with invalid attributes' do
        it 're-renders new view' do
          post :create, params: {category: attributes_for(:category, :no_name)}
          expect(response).to render_template :new
        end

        it 'does not create new record in database' do
          expect do
            post :create, params: {category: attributes_for(:category, :no_name)}
          end.to_not change(Category, :count)
        end
      end
    end

    context 'by guest' do
      before { post :create, params: {category: attributes_for(:category)} }

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end