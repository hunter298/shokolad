require 'rails_helper'

feature 'user can view the list of categories', '
In order to narrow down search
any visitor of the site
can overlook the list of all categories
' do
  given!(:user) { create(:user) }
  given!(:categories) { create_list(:category, 5) }

  scenario 'user tries to view list of all categories' do
    visit categories_path

    categories.each do |category|
      expect(page).to have_content category.name
    end
  end
end
