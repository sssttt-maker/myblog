class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.published.with_attached_image.includes(:categories).order('created_at DESC').page(params[:page]).per(8)
    @slide_posts = @category.posts.published.with_attached_image
  end
end
