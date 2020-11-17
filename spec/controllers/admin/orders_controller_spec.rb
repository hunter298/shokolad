require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  describe 'GET #index' do
    let(:admin) { create(:user, admin: true) }
    let(:user) { create(:user) }
    let!(:orders) { create_list(:order, 3) }

    context 'as admin' do
      before { login(admin) }
      it 'renders index view' do
        get :index
        expect(response).to render_template :index
      end

      it 'assigns all orders to instance variable' do
        get :index
        expect(assigns(:orders)).to match_array(orders)
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

  describe 'GET #show' do
    let(:admin) { create(:user, admin: true) }
    let(:user) { create(:user) }
    let!(:order) { create(:order) }

    context 'as admin' do
      before { login(admin) }
      it 'renders index view' do
        get :show, params: { id: order }
        expect(response).to render_template :show
      end

      it 'assigns order to instance variable' do
        get :show, params: { id: order }
        expect(assigns(:order)).to eq order
      end
    end

    context 'as user' do
      before { login(user) }

      it 'redirects to root page' do
        get :show, params: { id: order }
        expect(response).to redirect_to root_path
      end
    end

    context 'as guest' do
      it 'redirects to ligin page' do
        get :show, params: { id: order }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH #update' do
    let(:admin) { create(:user, admin: true) }
    let(:user) { create(:user) }
    let(:order) { create(:order) }

    context 'as admin' do
      before { login(admin) }
      it 'changes order attributes' do
        patch :update, params: { order: { status: 'shipped', payment_status: 'completed'}, id: order }
        expect(order.reload.status).to eq 'shipped'
        expect(order.reload.payment_status).to eq 'completed'
      end

      it 'assigns order to instance variable' do
        patch :update, params: { order: { status: 'shipped', payment_status: 'completed'}, id: order }
        expect(assigns(:order)).to eq order
      end
    end

    context 'as user' do
      before { login(user) }

      it 'redirects to root page' do
        patch :update, params: { order: { status: 'shipped', payment_status: 'completed'}, id: order }
        expect(response).to redirect_to root_path
      end
    end

    context 'as guest' do
      it 'redirects to ligin page' do
        patch :update, params: { order: { status: 'shipped', payment_status: 'completed'}, id: order }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end