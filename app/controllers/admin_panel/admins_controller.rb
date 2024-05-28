module AdminPanel
  class AdminsController < ApplicationController
    before_action :authenticate_admin!, only: :home

    def home
      @nonsense_posts = Post.where('nonsense > 0').includes(:user).order(nonsense: :desc)
    end

    def check
    end

    def check_password
      if params[:password] == 'securepassword'
        redirect_to new_admin_session_path
      else
        flash[:alert] = 'パスワードが間違っています。'
        render :check
      end
    end

    private

    def authenticate_admin!
      unless current_admin.present?
        redirect_to root_path, alert: '管理者権限が必要です。'
      end
    end
  end
end
