class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :post_category_relations
  has_many :categories, through: :post_category_relations

  enum published: { draft: false, published: true }

end
