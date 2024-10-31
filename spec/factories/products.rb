FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Unique Product #{n}" }
    description { "MyText" }
    price { 1 }
    active { false }
    association :category

    images { [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/cat.jpg'), 'image/jpg')] }
  end
end
