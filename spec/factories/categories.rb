FactoryBot.define do
  factory :category do
    name { "MyString" }
    description { "MyText" }
     association :user
  end
end
