require 'rails_helper'

RSpec.describe Cart, type: :model do
  it { should have_many(:cart_items) }

  it 'should have either user or cookies' do
    a = Cart.new(user: create(:user))
    expect { a.save }.to change(Cart, :count).by(1)

    b= Cart.new(cookies: 'test cookies')
    expect { b.save }.to change(Cart, :count).by(1)
  end
end
