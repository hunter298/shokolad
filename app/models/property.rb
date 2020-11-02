class Property < ApplicationRecord
  belongs_to :category
  has_many :product_properties, dependent: :destroy
  has_many :products, through: :product_properties
end
