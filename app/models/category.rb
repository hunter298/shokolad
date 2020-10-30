class Category < ApplicationRecord
  has_many :properties, dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :properties, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
