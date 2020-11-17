require 'rails_helper'

feature 'admin can open orders to view and change status', %q{
in order to view details, monitor and change statuses of orders
as an admin of store
i'd like to be able to open order from index page
} do
  given(:admin) { create(:user, admin: true) }
  given(:user) { create(:user) }
  given!(:order) { create(:order) }

  context 'admin' do
    background do
      sign_in(admin)
      visit admin_orders_path
      click_link "Order no #{order.id}"
    end

    scenario 'tries to view order' do
      %w[id full_name phone_number adress_line1 adress_line2 delivery_type payment_type price].each do |attr|
        expect(page).to have_content(order.send(attr))
      end
    end

    scenario 'tries to change order and payment status', js: true do
      page.select('Shipped', from: 'Status')
      save_and_open_page
      click_button 'Update Order'
      visit admin_order_path(order)
      expect(page).to have_select('Status', selected: 'Shipped')
    end
  end
end