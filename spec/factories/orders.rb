FactoryBot.define do
  factory :user_order, class: 'User::Order' do
    customer_email { "MyString" }
    fullfilled { false }
    total { 1 }
    address { "MyString" }
  end
end
