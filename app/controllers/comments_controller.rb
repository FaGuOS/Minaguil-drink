class CommentsController < ApplicationController
  before_action :set_post, only: [:index, :new, :create, :destroy]
  before_action :set_comment, only: [:destroy]

  def index
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: 'Add to Comments!'
    else
      redirect_to post_path(@post), alert: 'コメントの追加に失敗しました。'
    end
  end

  def destroy
    if @comment.destroy
      redirect_to post_path(@post), notice: 'Delete to Comments.'
    else
      redirect_to post_path(@post), alert: 'コメントの削除に失敗しました。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment_1, :comment_2)
  end
end

