class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :full_name, null: false
      t.string :phone_number, null: false
      t.string :adress_line1
      t.string :adress_line2
      t.string :city
      t.string :region
      t.string :zip
      t.string :country
      t.string :delivery_type, null: false
      t.string :payment_type, null: false
      t.decimal :price, precision: 6, scale: 2, null: false
      t.string :items_list, null: false
      t.string :message
      t.string :status, null: false, default: 'processing'
      t.string :payment_status, null: false, default: 'pending'

      t.timestamps
    end
  end
end
