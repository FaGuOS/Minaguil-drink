class HomesController < ApplicationController
  before_action :redirect_logged_in_user, only: :top
  #skip_before_action :authenticate_user!, only: [:top, :home]

  def top
    @new_reviews = Post.order(created_at: :desc).limit(4)
    @weekly_posts = Post.where('created_at >= ?', 7.days.ago)
                        .order(yes: :desc)
                        .limit(6)
  end

  def home
    @new_reviews = Post.order(created_at: :desc).limit(4) # 直近の投稿を取得
    @weekly_posts = Post.order(Arel.sql('RAND()')).limit(6) # MySQL用のランダムな投稿取得
  end

  private

  def redirect_logged_in_user
    redirect_to home_path if user_signed_in?
  end

  def admin_signed_in?
    current_admin.present?
  end
end
