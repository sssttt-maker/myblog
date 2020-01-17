class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def thumbnail
    return self.image.variant(combine_options: { resize: "480x270", extent: "240x135", background: "white", gravity: "center"})
  end

  def custom_thumbnail(a, b, c, d)
    return self.image.variant(combine_options: { resize: "#{a}x#{b}", extent: "#{c}x#{d}", background: "white", gravity: "center"})
  end

  def post_thumbnail
    return self.image.variant(combine_options: { resize: "690x460>", extent: "690x460", background: "white", gravity: "center"})
  end

  def mini_thumbnail
    return self.image.variant(combine_options: { resize: "120x120", extent: "80x80", background: "white", gravity: "center"})
  end

  def images_thumbnail
    return self.images[0].variant(combine_options: { resize: "120x160", extent: "90x120", background: "white", gravity: "center"})
  end
end
