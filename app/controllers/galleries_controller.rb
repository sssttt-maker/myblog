class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.all
  end

  def get_url
    @images = Gallery.find(image_params[:id]).images
    @description = Gallery.find(image_params[:id]).description
    @images_url = []
    @images.each do |image|
      resize_img = image.variant(combine_options: { resize: "440x550", extent: "440x550", background: "white", gravity: "center"})
      @images_url.push(url_for(resize_img))
    end

    render json: { url: @images_url, description: @description }.to_json
  end

  private

  def image_params
    params.require(:image).permit(:id)
  end
end
