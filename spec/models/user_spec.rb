require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid without an email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    User.create(
      email: "papo@example.com",
      password: "1987595",
    )
    user = User.new(
      email: "papo@example.com",  # Use the same email as the first user
      password: "1987875",
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
