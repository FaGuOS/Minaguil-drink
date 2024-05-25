class YesesController < ApplicationController
  before_action :set_post


  def create
    post = Post.find(params[:post_id])
    yes = current_user.yeses.new(post_id: post.id)
    if yes.save
      redirect_to post_path(post), notice: 'Yesしました!'
    else
      redirect_to post_path(post), alert: 'Yesに失敗しました。'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    yes = current_user.yeses.find_by(post_id: post.id)
    if yes.destroy
      redirect_to post_path(post), notice: 'Yesを取り消しました!'
    else
      redirect_to post_path(post), alert: 'Yesの取り消しに失敗しました。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
