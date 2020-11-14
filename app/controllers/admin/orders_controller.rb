class Admin::OrdersController < Admin::BaseController
  def index
    authorize! :manage, Order
    @orders = Order.all
  end
end