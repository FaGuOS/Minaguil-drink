class SearchesController < ApplicationController
  def index
    @query = params[:query]
    @search_type = params[:search_type]
    @search_category = params[:search_category]

    if @query.present?
      if @search_category == 'user'
        @users = User.looks(@search_type, @query)
        @posts = Post.none
      elsif @search_category == 'post'
        @users = User.none
        @posts = Post.looks(@search_type, @query)
      else
        @users = User.none
        @posts = Post.none
      end
    else
      @users = User.none
      @posts = Post.none
    end
  end
end