class Admin::GalleriesController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      redirect_to galleries_path
    else
      render :new
    end
  end

  private

  def gallery_params
    params.require(:gallery).permit(:description, images: [])
  end
end
