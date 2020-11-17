FactoryBot.define do
  sequence :full_name do |n|
    "Test fulllname #{n}"
  end

  sequence :phone_number do |n|
    "+1-541-754-30#{rand(30..99)}"
  end
  factory :order do
    full_name
    phone_number
    adress_line1 { "109 Hollywood Avenue" }
    adress_line2 { "apt 1" }
    city { "Birmingham" }
    region { "Orange County" }
    zip { "B35 4HE" }
    country { "Laplandia" }
    delivery_type { "Delivery service" }
    payment_type {"GooglePay"}
    message { "MyString" }
    status { "processing" }
    payment_status { "pending" }
    items_list { "100$ - Product1 (Value1, Value2)\n200$ - Product2 (Value3, Value4)" }
    price { 300 }
    email { 'test@test.test' }
    trait :no_full_name do
      full_name { '' }
    end
  end
end
