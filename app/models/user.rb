class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: {maximum: 50}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  def email_required?
    false
  end
  def email_changed?
    false
  end
end
