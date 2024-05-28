class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :user_signed_in?, :current_user, :user_session, :current_admin

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_panel_home_path
    else
      super
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
  end

  def current_admin
    current_user if current_user&.admin?
  end
end
