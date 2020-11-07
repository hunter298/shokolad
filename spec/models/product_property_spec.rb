require 'rails_helper'

RSpec.describe ProductProperty, type: :model do
  it { should belong_to(:product) }
  it { should belong_to(:property) }
  it { should validate_presence_of :value }
  it { should have_and_belong_to_many(:cart_items) }
end
