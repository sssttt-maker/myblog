class SitemapController < ApplicationController
  def index
    @categories = Category.all.includes(:posts)
  end
end
