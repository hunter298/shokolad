FactoryBot.define do
  sequence :property_name do |n|
    "Property #{n}"
  end
  factory :property do
    name { generate :property_name }
    category { nil }
  end
end
