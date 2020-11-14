require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  describe 'GET #index' do
    let(:admin) { create(:user, admin: true) }
    let(:user) { create(:user) }

    context 'as admin' do
      before { login(admin) }
      it 'renders index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'as user' do
      before { login(user) }

      it 'redirects to root page' do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    context 'as guest' do
      it 'redirects to ligin page' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end