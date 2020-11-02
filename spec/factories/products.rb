FactoryBot.define do
  sequence :product_name do |n|
    "product #{n}"
  end

  factory :product do
    name { generate(:product_name) }
    category { create :category }

    trait :no_name do
      name { '' }
    end
  end
end
