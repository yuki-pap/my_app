require 'rails_helper'

RSpec.describe User, type: :model do


  let(:user) { FactoryBot.create(:user)}

  it "has a valid factory" do

    expect(user).to be_valid

  end


  it "is invalid without a name" do
    user = User.new(name: nil)

    user.valid?

    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a email" do
    user = User.new(email: nil)

    user.valid?

    expect(user.errors[:email]).to include("can't be blank")
  end

  it {is_expected.to validate_length_of(:name).is_at_most(50)}

  it {is_expected.to validate_length_of(:email).is_at_most(255)}

  it {is_expected.to validate_length_of(:password).is_at_least(6)}

  describe "email validation should reject invalid addresses" do

    it "is invalid" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_addresses|
        user.email = invalid_addresses
        expect(user).to_not be_valid
      end

    end

    it "is valid" do
      valid_addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end

    end
  end

  it "is invalid with a duplicate email adress" do
    FactoryBot.create(:user,email: "essei@example.com")
    user = FactoryBot.build(:user,email:"Essei@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "authentiicated? should return false  with nil dijest" do
    boolean = user.authenticated?("")
    expect(boolean).to be_falsey

  end


end
