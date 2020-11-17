class CreateCartItemsProductPropertiesJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :cart_items, :product_properties do |t|
      t.index :cart_item_id
      t.index :product_property_id
    end
  end
end
