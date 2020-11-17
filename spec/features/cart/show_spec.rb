require 'rails_helper'

feature 'user can see a list of products in his cart' do
  given(:user) { create(:user) }
  given!(:products) { create_list(:product, 2) }

  context 'guest' do
    background do
      visit product_path(products.first)
      click_button 'Add to cart'
      visit product_path(products.last)
      click_button 'Add to cart'
    end

    scenario 'tries to go to his/her cart', js: true do
      find('.navbar-toggler-icon').click
      find('#cart-count').click

      products.each { |product| expect(page).to have_content(product.name) }
    end
  end
end