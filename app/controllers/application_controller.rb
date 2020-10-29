class ApplicationController < ActionController::Base
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
end
