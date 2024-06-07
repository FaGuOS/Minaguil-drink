class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :user_signed_in?, :current_user, :user_session, :admin_signed_in?, :current_admin

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_home_path
    when User
      root_path
    else
      super
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
  end

  private

  def authenticate_user!
    redirect_to new_user_session_path, alert: "You need to sign in to access this page." unless user_signed_in?
  end

  def authenticate_admin!
    redirect_to new_admin_session_path, alert: "You need to sign in as admin to access this page." unless admin_signed_in?
  end
end
