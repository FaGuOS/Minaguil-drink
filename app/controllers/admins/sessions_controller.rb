# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :check_admin, only: [:create]

  # GET /admin/login
  # def new
  #  super
  # end

  # POST /admin/login
def create
  admin = Admin.find_by(email: params[:admin][:email])
  if admin&.valid_password?(params[:admin][:password])
    set_flash_message!(:notice, :signed_in)
    sign_in(:admin, admin)
    redirect_to admins_home_path
  else
    flash[:alert] = "Invalid email or password."
    redirect_to new_admin_session_path
  end
end


  protected

  # 管理者ユーザーかどうかをチェックするメソッド
  # def check_admin
  #   user = Admin.find_by(email: params[:admin][:email])
  #   Rails.logger.debug "Check admin user: #{user.inspect}"
  #   unless user&.admin?
  #     flash[:alert] = "You are not authorized to access this page."
  #     redirect_to new_admin_session_path
  #   end
  # end

  # If you have extra params to permit, append them to the sanitizer.
  #def configure_sign_in_params
  #  devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  #end

  # 管理者ログイン後のリダイレクト先を設定する
  def after_sign_in_path_for(resource)
    admins_home_path
  end
end
