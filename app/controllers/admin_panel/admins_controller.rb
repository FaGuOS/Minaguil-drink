module AdminPanel
  class AdminsController < ApplicationController
    before_action :authenticate_admin!, only: :home
    skip_before_action :authenticate_user!, only: [:check, :check_password]

    def table_home
      @nonsense_posts = Post.where('nonsense > 0').includes(:user).order(nonsense: :desc)
    end

    def check
    end

    def check_password
      if params[:password] == 'arika89148'
        redirect_to new_admin_session_path
      else
        flash[:alert] = 'パスワードが間違っています。'
        render :check
      end
    end

    private

    def authenticate_admin!
      unless admin_signed_in?
        redirect_to new_admin_session_path, alert: '管理者権限が必要です。'
      end
    end

    def admin_signed_in?
      current_admin.present?
    end

    def current_admin
      current_admin_user
    end
  end
end