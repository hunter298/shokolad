FactoryBot.define do
  factory :order do
    full_name { "MyString" }
    phone_number { "MyString" }
    adress_line1 { "MyString" }
    adress_line2 { "MyString" }
    city { "MyString" }
    region { "MyString" }
    zip { "MyString" }
    country { "MyString" }
    delivery_type { "MyString" }
    price { "9.99" }
    items_list { "MyString" }
    message { "MyString" }
    status { "MyString" }
    payment_status { "MyString" }
  end
end
