require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { should have_many(:cart_items) }

  it 'should have either user or cookies' do
    a = Cart.new(user: create(:user))
    expect { a.save }.to change(Cart, :count).by(1)

    b= Cart.new(cookies: 'test cookies')
    expect { b.save }.to change(Cart, :count).by(1)
  end

  describe '#price' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:property) { create(:property, category: category) }
    let(:product) { create(:product, category: category, price: 100) }
    let(:other_product) { create(:product, category: category, price: 99) }
    let(:cart) { create(:cart, user: user) }
    let!(:cart_item) { create(:cart_item, product: product, cart: cart) }
    let!(:other_cart_item) { create(:cart_item, product: other_product, cart: cart) }

    it 'should return sum of products in cart prices' do
      expect(cart.price).to eq 199
    end
  end
end
