class AddPriceToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :price, :decimal, precision: 6, scale: 2, default: 0, null: false
  end
end
