class TagsController < ApplicationController
  
  def create
    @tag = Tag.find_or_create_by(name: params[:name])
    if @tag.save
      render json: @tag
    else
      render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts
  end
end
