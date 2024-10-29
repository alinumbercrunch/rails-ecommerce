FactoryBot.define do
  factory :order_product do
    product { nil }
    order { nil }
    size { "MyString" }
    quantity { 1 }
  end
end
