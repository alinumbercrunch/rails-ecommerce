require 'rails_helper'

describe Stock do
    it "has a valid factory" do
    expect(FactoryBot.build(:stock)).to be_valid
  end

    it "is invalid without a product" do
    stock = FactoryBot.build(:stock, product: nil)
    stock.valid?
    expect(stock.errors[:product]).to include("must exist")
  end

    it "is invalid without an amount" do
      stock = FactoryBot.build(:stock, amount: nil)
      stock.valid?
      expect(stock.errors[:amount]).to include("can't be blank")
    end

    it "is invalid without a size" do
      stock = FactoryBot.build(:stock, size: nil)
      stock.valid?
      expect(stock.errors[:size]).to include("can't be blank")
    end

end
