class Admins::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :check_admin, only: [:create]

  # GET /admin/login
  def new
    super
  end

  # POST /admin/login
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.admin?
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      sign_out resource
      flash[:alert] = "You are not authorized to access this page."
      redirect_to new_admin_session_path
    end
  end

  # DELETE /admin/logout
  def destroy
    super
  end

  protected

  # 管理者ユーザーかどうかをチェックするメソッド
  def check_admin
    user = User.find_by(email: params[:admin][:email])
    unless user&.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to new_admin_session_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end

