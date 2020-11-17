require 'rails_helper'

feature 'user can add products to cart to buy them together', %q{
in order to buy products together
as a guest user
i'd like to be able to add products to cart
} do

  context 'guest' do
    given(:product) { create(:product) }

    background { visit product_path(product) }

    scenario 'tries to add product to cart', js: true do
      click_button 'Add to cart'
      expect(page).to have_css("#cart-count", text: '1', visible: false) #not visible due to bootstrap collaspsible menu
      click_button 'Add to cart'
      expect(page).to have_css("#cart-count", text: '2', visible: false) #not visible due to bootstrap collaspsible menu
    end
  end
end