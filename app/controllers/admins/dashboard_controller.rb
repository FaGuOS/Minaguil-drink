class Admins::DashboardController < ApplicationController
  def index
    @users = User.all
    @posts = Post.all
  end

  def destroy_user
    user = User.find(params[:id])
    user.destroy
    redirect_to admins_dashboard_index_path, notice: 'User was successfully deleted.'
  end

  def destroy_post
    post = Post.find(params[:id])
    post.comments.destroy_all
    post.yeses.destroy_all
    post.taggings.destroy_all
    post.destroy
    redirect_to admins_dashboard_index_path, notice: 'Post was successfully deleted.'
  rescue ActiveRecord::InvalidForeignKey
    redirect_to admins_dashboard_index_path, alert: 'Failed to delete the post due to foreign key constraint.'
  end
end
