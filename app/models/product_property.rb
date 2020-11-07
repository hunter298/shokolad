class ProductProperty < ApplicationRecord
  belongs_to :product
  belongs_to :property
  has_and_belongs_to_many :cart_items

  validates :value, presence: true
end
