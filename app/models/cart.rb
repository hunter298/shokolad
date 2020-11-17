class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy

  validates :user_id, presence: true, unless: :cookies
  validates :cookies, presence: true, unless: :user_id

  def price
    cart_items.sum { |item| item.product.price }
  end

  def items_list
    text = ''
    cart_items.each do |item|
      text << item.product.price.to_s << '$ - ' << item.product.name << ' (' << item.product_properties.pluck(:value).join(', ') << ")\n"
    end
    text[0..-2]
  end
end
