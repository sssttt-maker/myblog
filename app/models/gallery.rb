class Gallery < ApplicationRecord
  has_many :gallery_category_relations
  has_many :categories, through: :gallery_category_relations
  has_many_attached :images
end
