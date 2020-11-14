require 'rails_helper'

feature 'admin can see all orders', %q{
in order to detect new orders and monitor execution of existing ones
as an admin of store
i'd like to be able to see a list of all orders
} do
  context 'admin' do
    given(:admin) { create(:user, admin: true) }

    background do
      sign_in(admin)
    end

    scenario 'tries to go to orders index page' do
      visit admin_orders_path
      expect(page).to have_content 'All orders'
    end
  end

  context 'guest' do
    scenario 'tries to go to orders index page' do
      visit admin_orders_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  context 'user' do
    given(:user) { create(:user) }

    background do
      sign_in(user)
    end

    scenario 'tries to go to orders index page' do
      visit admin_orders_path
      expect(page).to have_content 'You are not authorized for this page'
    end
  end

  context 'multiple sessions' do
    given(:admin) { create(:user, admin: true) }
    given(:product) { create(:product) }

    scenario 'admin can see new orders in real time on orders index page', js: true do
      Capybara.using_session('admin') do
        sign_in(admin)
        visit admin_orders_path
      end

      Capybara.using_session('guest') do
        visit product_path(product)
        click_button 'Add to cart'

        #to open bootstraap collapsible toggle and go to cart
        find('.navbar-toggler-icon').click
        find('#cart-count').click
        click_link 'Checkout'
        fill_in 'Full name', with: 'John Brown'
        fill_in 'Phone number', with: '+1-541-754-3010'
        click_on 'Place order'
      end

      Capybara.using_session('admin') do
        expect(page).to have_content('John Brown')
      end
    end
  end
end
