require 'rails_helper'

feature 'user can view the page of product to continue shopping', '
in order to find out details about product or add to cart
any user visiting site
should be able to view the product page
' do
  given(:user) { create(:user) }
  given(:category) { create(:category) }
  given(:product) { create(:product, category: category) }
  given(:properties) { create_list(:property, 3, category: category) }
  given(:product_properties) { create(:product_property, 3, product: product, property: properties.first) }


  background do
    product.images.attach(io: File.open("#{Rails.root}/spec/support/uploads/tshirt.jpeg"), filename: 'tshirt.jpeg')
    product.images.attach(io: File.open("#{Rails.root}/spec/support/uploads/black.jpeg"), filename: 'black.jpeg')
    sign_in(user)
    visit category_path(category)
  end

  scenario 'tries to view product from list' do
    click_on product.name
    expect(page).to have_content product.name
    expect(page).to have_content product.description
    product.properties.each do |property|
      expect(page).to have_content property.name
    end
    product.properties.each do |pp|
      expect(page).to have_content pp.value
    end
  end
end
