class ApplicationController < ActionController::Base
  check_authorization unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        path = current_user ? root_path : new_user_session_path
        redirect_to path, alert: exception.message
      end
      format.json { render json: { error: exception.message }, status: :forbidden }
      format.js { head :forbidden }
    end
  end

  protected

  def current_cart
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

  helper_method :current_cart

end
