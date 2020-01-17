class Admin::HomeController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  def index
    @posts = current_user.posts
    @published = @posts.published
    @drafts = @posts.draft
    @categories = Category.all
  end
end
