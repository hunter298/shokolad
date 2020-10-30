require 'rails_helper'

feature 'admin can add property to category', %q{
in order to specify some characteristic of product
as an store admin
i'd like to be able to add properties to category of product
} do
  given(:admin) { create(:user, admin: true) }

  background do
    sign_in(admin)
    visit categories_path
    click_link 'Create category'
  end

  scenario 'addin property during creation of category' do
    fill_in 'Name', with: 'Test category name'
    fill_in 'Property name', with: 'Size'

    click_on 'Create'
    expect(page).to have_content 'Category successfully created!'
    expect(page).to have_content 'Size'
  end
end