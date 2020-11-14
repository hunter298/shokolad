class Order < ApplicationRecord
  validates :full_name, :phone_number, :delivery_type, :payment_type, :price, :items_list, :status, :payment_status,
            presence: true
  validates :full_name, :adress_line1, :adress_line2, length: { maximum: 100 }
  validates :city, :region, :zip, :country, length: { maximum: 20 }
  validates :phone_number, format: { with: /(\+?\d{1,3}[- ]?)?\(?(\d{3})?\)?[- ]?\d{3}[- ]?\d{2}[- ]?\d{2}/ }
  validates :delivery_type, inclusion: { in: ['Courier', 'Delivery service', 'Self-pickup'] }
  validates :payment_type, inclusion: { in: ['GooglePay', 'Card', 'On delivery'] }
end
