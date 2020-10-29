require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
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
    before { get :new }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates new record in database' do
        expect { post :create, params: { category: attributes_for(:category) } }.to change(Category, :count).by(1)
      end

      it 'renders show view' do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to(assigns :category)
      end
    end

    context 'with invalid attributes' do
      it 're-renders new view' do
        post :create, params: { category: attributes_for(:category, :no_name) }
        expect(response).to render_template :new
      end

      it 'does not create new record in database' do
        expect do
          post :create, params: { category: attributes_for(:category, :no_name) }
        end.to_not change(Category, :count)
      end
    end
  end
end