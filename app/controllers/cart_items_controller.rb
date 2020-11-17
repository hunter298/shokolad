class CartItemsController < ApplicationController
  before_action :current_cart, only: %i{create}

  authorize_resource

  def create
    authorize! :create, CartItem
    @cart_item = @cart.cart_items.create(product_id: params[:product_id])
    params[:properties]&.each do |property|
      @cart_item.product_properties << ProductProperty.find(property)
    end

    respond_to do |format|
      format.json { render json: @cart.cart_items.count }
    end
  end

end