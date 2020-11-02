require 'rails_helper'

RSpec.describe Property, type: :model do
  it { should belong_to(:category) }
  it { should have_many(:product_properties).dependent(:destroy) }
  it { should have_many(:products).through(:product_properties) }
end
