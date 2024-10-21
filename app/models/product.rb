class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  belongs_to :category

end
# ss
