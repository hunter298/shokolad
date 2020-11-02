require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:properties).dependent(:destroy)}
  it { should have_many(:products).dependent(:destroy)}
  it { should validate_presence_of :name }

  it 'has attached logo image' do
    expect(Category.new.image).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end
