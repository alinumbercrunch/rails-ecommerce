FactoryBot.define do
  factory :user_product, class: 'User::Product' do
    name { "MyString" }
    description { "MyText" }
    price { 1 }
    category { nil }
    active { false }
  end
end
