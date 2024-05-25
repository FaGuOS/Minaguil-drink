class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :hide, :hide_selected, :nonsence]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :hide, :nonsence]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :admin_user, only: [:hide_selected]

  # GET /posts/rankings
  def rankings
    @posts = Post.order(yes: :desc).limit(10)
  end

  # GET /posts/weekly_ranking
  def weekly_ranking
    one_week_ago = 7.days.ago
    @posts = Post.where('created_at >= ?', one_week_ago)
                 .order(yes: :desc)
                 .limit(10)
  end

  # GET /posts
  def index
    @posts = Post.all
    @posts = @posts.order("#{params[:sort]} #{params[:direction]}") if params[:sort].present? && params[:direction].present?
    @posts = @posts.page(params[:page]).per(20)
  end

  # GET /posts/:id
  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = @post.comments.build
    increment_view_count unless @post.user == current_user
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    unless @post.image.attached?
      @post.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'Reviewonly.png')), filename: 'Reviewonly.png', content_type: 'image/png')
    end

    if @post.save
      redirect_to @post, notice: 'SUCCESS!!'
    else
      flash.now[:alert] = 'FAIL, Can you try that one more time?'
      render :new
    end
  end

  # GET /posts/:id/edit
  def edit
  end

  # PUT /posts/:id
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'UPDATED!!'
    else
      flash[:alert] = 'FAIL, Can you try that one more time?'
      render :edit
    end
  end

  # PUT /posts/:id/hide
  def hide
    @post.update(hidden: true)
    redirect_to posts_url, notice: 'This post has been hidden.'
  end
  
  # DELETE /posts/:id
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'DELETED...!'
  end

  def increment_view_count
    @post.increment!(:view_count)
  end
  
  def increment_yes
    @post = Post.find(params[:id])
    yes = Yes.find_by(user: current_user, post: @post)

    if yes
      yes.destroy
      @post.decrement!(:yes)
      render json: { status: 'unliked', yes_count: @post.yes }
    else
      Yes.create(user: current_user, post: @post)
      @post.increment!(:yes)
      render json: { status: 'liked', yes_count: @post.yes }
    end
  end
  
  def create_comment
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully added.'
    else
      @comments = @post.comments.order(created_at: :desc)
      render :show
    end
  end
  
  def bookmark
    # ブックマーク処理の実装（後で追加）
    render json: { bookmarked: true }
  end

  # PUT /posts/hide_selected
  def hide_selected
    Post.where(id: params[:post_ids]).update_all(hidden: true)
    redirect_to posts_path, notice: 'Selected posts have been hidden.'
  end

  # POST /posts/:id/nonsence
  def nonsence
    current_user.hidden_posts << @post
    @post.increment!(:nonsence)
    redirect_to posts_path, notice: 'Post has been marked as nonsence and hidden.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :review, :image, :policy_agreement, :yes, :nonsence, :hidden)
  end

  def comment_params
    params.require(:comment).permit(:comment_1, :comment_2)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: 'Not authorized to edit this post' if @post.nil?
  end
  
  def sort_column
    if current_user.admin?
      %w[created_at yes nonsence].include?(params[:sort]) ? params[:sort] : 'created_at'
    else
      %w[created_at yes].include?(params[:sort]) ? params[:sort] : 'created_at'
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def admin_user
    redirect_to(root_url) unless current_user&.admin?
  end
end
