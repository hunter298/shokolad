require 'rails_helper'

feature 'user can view the category to find desired product', '
in order to find needed product
any user visiting site
should be able to view the category along with its products
' do
  given!(:user) { create(:user) }
  given!(:category) { create(:category) }
  given!(:products) { create_list(:product, 3, category: category) }


  context 'guest user' do
    background do
      sign_in(user)
      visit categories_path
      click_on category.name
    end

    scenario 'tries to view categories from list' do
      expect(page).to have_content category.name

      products.each do |product|
        expect(page).to have_content product.name
        expect(page).to have_content product.name.truncate(25)
      end
    end

    scenario 'tries to add product from category page' do
      expect(page).to_not have_link 'Add_product'
    end
  end

  context 'admin' do
    background do
      sign_in(create(:user, admin: true))
      visit category_path(category)
    end

    scenario 'user tries to add product from category page' do
      expect(page).to have_link 'Add product'
    end

    scenario 'tries to create product of current category' do
      click_link 'Add product'
      expect(page).to have_select('product_category_id', selected: category.name)
    end
  end
end
