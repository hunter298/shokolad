require 'rails_helper'

feature 'admin can create question', %q{
in order to divide products for easier search for clients,
as an administrator
i'd like to be able to create a category
} do
  given(:user) { create(:user) }

  context 'admin' do
    background do
      sign_in(user)

      visit categories_path
      click_on 'Create category'

    end

    scenario 'tries to create category with valid data' do
      fill_in 'Name', with: 'Test category name'
      click_on 'Create'

      expect(page).to have_content 'Category successfully created!'
      expect(page).to have_content 'Test category name'
    end

    scenario 'tries to create category with invalid data' do
      fill_in 'Name', with: ''
      click_on 'Create'

      expect(page).to have_content "Name can't be blank"
    end
  end

  context 'not admin' do
    scenario 'tries to create category' do
      visit categories_path

      expect(page).to_not have_link 'Create category'
    end
  end
end