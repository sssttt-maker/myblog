class PostsController < ApplicationController
  def index
    @slide_posts = Post.published.with_attached_image
    @posts = Post.published.with_attached_image.includes(:categories).order('created_at DESC').page(params[:page]).per(8)
  end

  def show
    @post = Post.find(params[:id])
    if @post.published?
      @post
    else
      authenticate_user!
      @post
    end
  end
end
