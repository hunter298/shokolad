class Admin::OrdersController < Admin::BaseController
  ORDER_STATUSES = ['processing', 'awaiting payment', 'canceled', 'shipped', 'awaiting pickup', 'completed']
  PAYMENT_STATUSES = ['pending', 'completed', 'failed']
  def index
    authorize! :manage, Order
    @orders = Order.all
  end

  def show
    authorize! :read, Order
    @order = Order.find(params[:id])
  end

  def update
    authorize! :update, Order
    @order = Order.find(params[:id])
    @order.update!(order_params)
  end

  private

  def order_params
    params.require(:order).permit(:status, :payment_status)
  end
end