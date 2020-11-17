class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :full_name, null: false, limit: 100
      t.string :phone_number, null: false, limit: 15
      t.string :email, nul: false, limit: 30
      t.string :adress_line1, limit: 100
      t.string :adress_line2, limit: 100
      t.string :city, limit: 20
      t.string :region, limit: 20
      t.string :zip, limit: 20
      t.string :country, limit: 20
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
