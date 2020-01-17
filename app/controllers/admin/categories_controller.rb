class Admin::CategoriesController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: "カテゴリを追加しました。"
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_back(fallback_location: root_path, notice: "カテゴリ「#{@category.name}」を削除しました。")
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
