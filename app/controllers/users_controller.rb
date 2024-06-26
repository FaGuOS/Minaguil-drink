# app/controllers/users_controller.rb
class UsersController < ApplicationController 
  before_action :set_user, only: [:show, :activity]
  before_action :authenticate_user!, only: [:exit, :good_bye, :show, :activity]

  def show
    @posts = @user.posts.order(created_at: :desc)
    @total_yes = @user.posts.sum(:yes) # yesカラムの合計
    @post = @posts.first # 例として最初の投稿を@postに設定
  end

  def exit
    # 退会画面の表示
  end

  def good_bye
    # ユーザーの退会処理
    current_user.destroy
    redirect_to root_path, notice: 'Good bye. サービスをご利用いただき、ありがとうございました。'
  end

  def activity
    @recent_posts = current_user.posts.order(created_at: :desc).limit(10)
    @viewed_posts = current_user.viewed_posts.order('views.created_at DESC').limit(10)
    @yes_posts = Post.joins(:yeses).where(yeses: { user_id: current_user.id }).order('yeses.created_at DESC').limit(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
