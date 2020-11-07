class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy

  validates :user_id, presence: true, unless: :cookies
  validates :cookies, presence: true, unless: :user_id

end
