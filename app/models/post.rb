class Post < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  has_one_attached :image
  has_many :post_category_relations
  has_many :categories, through: :post_category_relations

  enum published: { draft: false, published: true }

  validate :image_presence

  def image_presence
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png image/jpg'))
        errors.add(:image, 'にはjpeg, jpgまたはpngファイルを添付してください')
      end
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end
end
