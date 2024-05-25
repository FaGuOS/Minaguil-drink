class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def create
    post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.new(post_id: post.id)
    if bookmark.save
      redirect_to post_path(post), notice: 'ブックマークしました!'
    else
      redirect_to post_path(post), alert: 'ブックマークに失敗しました。'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.find_by(post_id: post.id)
    if bookmark.destroy
      redirect_to post_path(post), notice: 'ブックマークを解除しました!'
    else
      redirect_to post_path(post), alert: 'ブックマークの解除に失敗しました。'
    end
  end

  def index
    @bookmarked_posts = current_user.bookmarks.map(&:post)
  end


  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
