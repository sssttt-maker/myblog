class SitemapController < ApplicationController
  def index
    @categories = Category.all
  end
end
