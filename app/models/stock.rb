class Stock < ApplicationRecord
  validates :amount, :size, presence: true
  belongs_to :product
end
