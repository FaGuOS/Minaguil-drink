class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :taggings
  has_many :posts, through: :taggings
end
