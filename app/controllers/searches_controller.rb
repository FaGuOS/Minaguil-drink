class SearchesController < ApplicationController
  def index
    @query = params[:query]
    @search_type = params[:search_type]
    @search_category = params[:search_category]

    Rails.logger.debug "Search Query: #{@query}"
    Rails.logger.debug "Search Type: #{@search_type}"
    Rails.logger.debug "Search Category: #{@search_category}"

    if @query.present?
      case @search_category
      when 'ユーザー'
        @users = User.looks(@search_type, @query)
        Rails.logger.debug "User search results: #{@users.to_a}"
        @posts = Post.none
        @tags = Tag.none
      when 'レビュー'
        @users = User.none
        @posts = Post.looks(@search_type, @query)
        Rails.logger.debug "Post search results: #{@posts.to_a}"
        @tags = Tag.none
      when 'タグ'
        @users = User.none
        @tags = Tag.where("name LIKE ?", "%#{@query}%")
        Rails.logger.debug "Tag search results: #{@tags.to_a}"
        @posts = Post.joins(:tags).where(tags: { id: @tags.pluck(:id) })
        Rails.logger.debug "Posts by tag search results: #{@posts.to_a}"
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