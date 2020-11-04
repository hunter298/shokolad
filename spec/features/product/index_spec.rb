require 'rails_helper'

feature 'user can view the list of products', %q{
in order to begin shopping
as a guest user
i'd like to be able to see list of all available products
} do
  given(:user) { create(:user) }
  given(:categories) { create_list(:category, 2) }
  given!(:products) { create_list(:product, 2, category: categories.first) }
  given!(:other_products) { create_list(:product, 2, category: categories.last) }

  scenario 'user tries to view list of all products' do
    visit root_path

    products.each do |product|
      expect(page).to have_content product.name
      expect(page).to have_content product.description.truncate(25)
    end

    other_products.each do |product|
      expect(page).to have_content product.name
      expect(page).to have_content product.description.truncate(25)
    end
  end
end
