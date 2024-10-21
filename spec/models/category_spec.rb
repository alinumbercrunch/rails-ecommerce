require 'rails_helper'

# RSpec.describe Category, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Category do
  it "has a valid factory" do
    expect(FactoryBot.build(:category)).to be_valid
  end

  it "is invalid without a name" do
    category = FactoryBot.build(:category, name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    category = FactoryBot.build(:category, description: nil)
    category.valid?
    expect(category.errors[:description]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    FactoryBot.create(:category)
    category = FactoryBot.build(:category)
    category.valid?
    expect(category.errors[:name]).to include("has already been taken")
  end
end
