# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:exit, :good_bye]
  before_action :set_user, only: :show

  def show
    @posts = @user.posts.order(created_at: :desc)
    @total_yes = @user.posts.sum(:yes) # ここでyesカラムを合計します
  end

  def exit
    # 退会画面の表示
  end

  def good_bye
    # ユーザーの退会処理
    current_user.destroy
    redirect_to root_path, notice: 'Good bye. サービスをご利用いただき、ありがとうございました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
