FactoryBot.define do
  sequence :name do |n|
    "category #{n}"
  end
  factory :category do
    name

    trait :no_name do
      name { nil }
    end
  end
end
