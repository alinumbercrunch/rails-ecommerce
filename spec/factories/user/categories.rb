FactoryBot.define do
  factory :user_category, class: 'User::Category' do
    name { "MyString" }
    description { "MyText" }
  end
end
