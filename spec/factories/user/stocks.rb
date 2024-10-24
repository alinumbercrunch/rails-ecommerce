FactoryBot.define do
  factory :user_stock, class: 'User::Stock' do
    product { nil }
    amount { 1 }
    size { "MyString" }
  end
end
