require "vips"
class Category < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [50,50]
  end
    has_many :products, dependent: :destroy
end
