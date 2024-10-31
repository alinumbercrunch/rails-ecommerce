FactoryBot.define do
  factory :stock do
    association :product
    amount { 1 }
    size { "MyString" }
  end
end
