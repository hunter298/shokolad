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
  end

  scenario 'tries to checkout', js: true do
    page.select(product_properties.last.value, from: property.name)
    click_button 'Add to cart'

    #to open bootstraap collapsible toggle and go to cart
    find('.navbar-toggler-icon').click
    find('#cart-count').click
    click_link 'Checkout'

    expect(page).to have_content 'Order review'
  end
end