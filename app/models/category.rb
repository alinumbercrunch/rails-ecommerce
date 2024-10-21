require "vips"
class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [50,50]
  end
end
