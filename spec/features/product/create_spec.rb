require 'rails_helper'

feature 'admin can add products', %q{
in order to provide information about exact product for clients,
as an administrator
i'd like to be able to create a product of certain category
} do
  given(:user) { create(:user, admin: true) }
  given(:category) { create(:category) }
  given(:other_category) { create(:category) }

  context 'admin' do
    background do
      other_category.properties.create(name: 'property 1')
      other_category.properties.create(name: 'property 2')
      sign_in(user)

      visit category_path(category)
      click_on 'Add product'
    end

    scenario 'tries to add product with valid data' do
      fill_in 'Name', with: 'Test product name'
      fill_in 'Description', with: 'Test product description'
      click_on 'Create'

      expect(page).to have_content 'Product successfully added!'
      expect(page).to have_content 'Test product name'
    end

    scenario 'tries to create product with invalid data' do
      fill_in 'Name', with: ''
      click_on 'Create'

      expect(page).to have_content "Name can't be blank"
    end

    scenario 'tries to add product images during creation' do
      fill_in 'Name', with: 'Test product name'
      attach_file 'Images', ["#{Rails.root}/spec/support/uploads/black.jpeg",
                             "#{Rails.root}/spec/support/uploads/blue.jpeg",
                             "#{Rails.root}/spec/support/uploads/red.jpeg"]
      click_on 'Create'

      expect(page).to have_css("img[src*='red.jpeg']")
      expect(Product.last.images.count).to eq 3
    end

    scenario 'tries to change category of product', js: true do
      page.select other_category.name, from: 'product_category_id'

      expect(page).to have_select('Properties', options: ['property 1', 'property 2'])
    end
  end

  context 'not admin' do
    scenario 'tries to add product' do
      visit category_path(category)

      expect(page).to_not have_link 'Add product'
    end
  end
end