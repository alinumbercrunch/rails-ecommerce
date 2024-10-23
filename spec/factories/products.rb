FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Unique Product #{n}" }
    description { "MyText" }
    price { 1 }
    active { false }
    association :category
  end
end
