class Product < ApplicationRecord
  belongs_to :category
  has_many :product_properties, dependent: :destroy
  has_many :properties, through: :product_properties

  has_many_attached :images

  accepts_nested_attributes_for :product_properties, reject_if: proc { |attr| attr['value'].blank?}, allow_destroy: true

  validates :name, presence: true
end
