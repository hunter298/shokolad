class CartsController < ApplicationController
  def show
    current_ability.cookies[:cart] = cookies[:cart]
    authorize! :read, current_cart
    @cart = current_cart
  end
end