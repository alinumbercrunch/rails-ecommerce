require 'rails_helper'

# RSpec.describe Product, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Product do
  it "has a valid factory" do
    expect(FactoryBot.build(:product)).to be_valid
  end

  it "is invalid without a category" do
    product = FactoryBot.build(:product, category: nil)
    product.valid?
    expect(product.errors[:category]).to include("must exist")
  end

  it "is invalid without a name" do
    product = FactoryBot.build(:product, name: nil)
    product.valid?
    expect(product.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    product = FactoryBot.build(:product, description: nil)
    product.valid?
    expect(product.errors[:description]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    FactoryBot.create(:product, name: "Shoes")
    product = FactoryBot.build(:product, name: "Shoes")
    product.valid?
    expect(product.errors[:name]).to include("has already been taken")
  end
end

# describe Category do
#   it "has a valid factory" do
#     expect(FactoryBot.build(:category)).to be_valid
#   end

#   it "is invalid without a name" do
#     category = FactoryBot.build(:category, name: nil)
#     category.valid?
#     expect(category.errors[:name]).to include("can't be blank")
#   end

#   it "is invalid without a description" do
#     category = FactoryBot.build(:category, description: nil)
#     category.valid?
#     expect(category.errors[:description]).to include("can't be blank")
#   end

#   it "is invalid with a duplicate name" do
#     FactoryBot.create(:category)
#     category = FactoryBot.build(:category)
#     category.valid?
#     expect(category.errors[:name]).to include("has already been taken")
#   end
# end
