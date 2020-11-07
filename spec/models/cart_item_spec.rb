require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it { should belong_to :cart }
  it { should have_and_belong_to_many :product_properties }
end
