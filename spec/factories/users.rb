# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    # email { "alip2258@test.com" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "741258" }
  end
end
