class AddProductIdToCartItem < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :product_id, :integer, null: false
  end
end
