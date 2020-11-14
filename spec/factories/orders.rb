FactoryBot.define do
  factory :order do
    full_name { "John Brown" }
    phone_number { "+1-541-754-3010" }
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

    trait :no_full_name do
      full_name { '' }
    end
  end
end
