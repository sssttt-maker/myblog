class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.published.order('created_at DESC').page(params[:page]).per(8)
    @slide_posts = @category.posts.published
  end
end
