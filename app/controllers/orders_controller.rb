class OrdersController < ApplicationController
  after_action :publish_order, only: %i{create}
  def new
    authorize! :create, Order
    @order = Order.new(price: cart.price, items_list: cart.items_list)
  end

  def create
    authorize! :create, Order
    @order = Order.new(order_params.merge(price: cart.price, items_list: cart.items_list))

    if @order.save
      redirect_to root_path, notice: 'Order placed'
      current_cart.cart_items.destroy_all
    else
      render :new
    end
  end

  private

  def cart
    @cart = Cart.find(params[:cart_id])
  end

  def order_params
    params.require(:order).permit(:full_name, :phone_number, :adress_line1, :adress_line2, :city, :region, :country,
                                  :delivery_type, :payment_type, :message)
  end

  def publish_order
    return if @order.errors.any?

    ActionCable.server.broadcast 'orders', ApplicationController.render(partial: 'admin/orders/order',
                                                                        locals: { order: @order })
  end


end