require 'rails_helper'

describe Category do
   it "has a valid factory" do
    expect(FactoryBot.build(:order)).to be_valid
  end
end
