FactoryBot.define do
  sequence :value do |n|
    "Value-#{n}"
  end

  factory :product_property do
    product { nil }
    property { nil }
    value
  end
end
