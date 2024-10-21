FactoryBot.define do
  factory :product do
    name { "MyString" }
    description { "MyText" }
    price { 1 }
    active { false }
    association :category
  end
end
