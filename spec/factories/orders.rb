FactoryBot.define do
  factory :order do
    customer_email { "MyString" }
    fullfilled { false }
    total { 1 }
    address { "MyString" }
  end
end
