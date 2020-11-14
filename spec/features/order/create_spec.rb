require 'rails_helper'

feature 'guest/user can place order based on cart to complete purchase', %q{
in order to summarize content of my cart and proceed to payment
as a guest/user of store
i'd like to be able to checkout my order
} do
  given(:category) { create(:category) }
  given(:property) { create(:property, category: category) }
  given!(:product) { create(:product, category: category) }
  given!(:product_properties) { create_list(:product_property, 3, product: product, property: property) }

  background do
    visit product_path(product)
    page.select(product_properties.last.value, from: property.name)
    click_button 'Add to cart'

    #to open bootstraap collapsible toggle and go to cart
    find('.navbar-toggler-icon').click
    find('#cart-count').click
    click_link 'Checkout'
  end

  scenario 'tries to checkout', js: true do
    expect(page).to have_content 'Order review'
    expect(page).to have_content product.name
    expect(page).to have_content product.price
  end

  context 'tries to place order' do
    scenario 'with valid data', js: true do
      fill_in 'Full name', with: 'John Brown'
      fill_in 'Phone number', with: '+1-541-754-3010'
      click_on 'Place order'

      expect(page).to have_content 'Order placed'
      expect(page).to have_css('#cart-count', text: '0', visible: false)
    end

    scenario 'with no data', js: true do
      fill_in 'Full name', with: ''
      fill_in 'Phone number', with: ''
      click_on 'Place order'

      expect(page).to have_content "Full name can't be blank"
      expect(page).to have_content "Phone number can't be blank"
    end

    scenario 'with invalid data', js: true do
      fill_in 'Full name', with: 'text'*100
      fill_in 'Phone number', with: 'number'
      click_on 'Place order'

      expect(page).to have_content "Full name is too long"
      expect(page).to have_content "Phone number is invalid"
    end
  end
end