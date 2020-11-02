require 'rails_helper'

feature 'admin can add various product properties', %q{
in order to provide client with different options of available product
as an admin
i'd like to be able to specify them during addition of product
} do
  given(:admin) { create(:user, admin: true) }
  given(:category) { create(:category) }
  given(:other_category) { create(:category) }

  background do
    category.properties.create(name: 'Test property 1')
    category.properties.create(name: 'Test property 2')
    other_category.properties.create(name: 'Other test property')
    sign_in(admin)
    visit category_path(category)
    click_link 'Add product'
    fill_in 'Name', with: 'Test product name'
  end

  scenario 'admin during addition of product tries to specify properties' do
    expect do
      page.select('Test property 2', from: 'Properties')
      fill_in 'Value', with: 'Property test value'
      click_button 'Create Product'
    end.to change(ProductProperty, :count).by(1)
  end

  scenario 'admin tries to add product to another category', js: true do
    select other_category.name, from: 'product_category_id'
    expect(page).to have_select('Properties', selected: 'Other test property')
  end


end