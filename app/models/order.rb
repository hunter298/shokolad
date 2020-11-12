class Order < ApplicationRecord
  validates :full_name, :phone_number, :delivery_type, :payment_type, :price, :items_list, :status, :payment_status,
            presence: true
end
