require 'rails_helper'

feature 'user can add products to cart to buy them together', %q{
in order to buy products together
as a guest user
i'd like to be able to add products to cart
} do

  context 'guest' do
    given(:product) { create(:product) }

    background { visit product_path(product) }

    scenario 'tries to add product to cart' do
      expect { click_button 'Add to cart' }.to change(CartItem, :count).by(1)
    end
  end
end