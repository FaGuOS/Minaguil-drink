class SearchesController < ApplicationController
  def index
    @query = params[:query]
    @search_type = params[:search_type]
    @search_category = params[:search_category]

    if @query.present?
      case @search_category
      when 'user'
        @users = User.looks(@search_type, @query)
        @posts = Post.none
        @tags = Tag.none
      when 'post'
        @users = User.none
        @posts = Post.looks(@search_type, @query)
        @tags = Tag.none
      when 'tag'
        @users = User.none
        @tags = Tag.where("name LIKE ?", "%#{@query}%")
        @posts = Post.joins(:tags).where(tags: { id: @tags.pluck(:id) })
      else
        @users = User.none
        @posts = Post.none
        @tags = Tag.none
      end
    else
      @users = User.none
      @posts = Post.none
      @tags = Tag.none
    end
  end
end
