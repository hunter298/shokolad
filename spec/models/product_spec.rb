require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_many(:product_properties).dependent(:destroy)}
  it { should have_many(:properties).through(:product_properties)}
  it { should belong_to(:category) }

  it { should validate_presence_of :name }

  it 'has many attached images' do
    expect(Product.new.images).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end
