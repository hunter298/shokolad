class CartItemsController < ApplicationController
  before_action :check_cart, only: %i{create}

  authorize_resource

  def create
    authorize! :create, CartItem
    @cart_item = @cart.cart_items.create(product_id: params[:product_id])
    params[:properties]&.each do |property|
      @cart_item.product_properties << ProductProperty.find(property)
    end
  end

  private

  def check_cart
    if current_user
      if current_user.cart
        @cart = current_user.cart
      else
        @cart = current_user.create_cart
      end
    elsif cookies[:cart]
      @cart = Cart.find_by(cookies: cookies[:cart])
    else
      hex = SecureRandom.hex
      cookies[:cart] = hex
      @cart = Cart.create(cookies: hex)
    end
  end

end