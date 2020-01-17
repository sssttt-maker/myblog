class Category < ApplicationRecord
  has_many :post_category_relations
  has_many :posts, through: :post_category_relations
  has_many :gallery_category_relations
  has_many :galleries, through: :gallery_category_relations
end
