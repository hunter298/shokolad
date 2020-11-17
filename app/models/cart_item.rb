class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  has_and_belongs_to_many :product_properties
end
