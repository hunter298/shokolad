class ProductProperty < ApplicationRecord
  belongs_to :product
  belongs_to :property

  validates :value, presence: true
end
