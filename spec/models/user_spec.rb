require "rails_helper"

RSpec.describe User, type: :model do
  describe "Validations:" do
    before(:each) do
      @user = User.new(
        first_name: "Joe",
        last_name: "Shmoe",
        email: "Joe@shmoe.com",
        password: "test",
        password_confirmation: "test",
      )
    end

    it "the user is valid with proper fields" do
      expect(@user).to be_valid
    end

    it "is required to have a password" do
      @user.password = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Password can't be blank")).to be_truthy
    end

    it "is required to have a password confirmation" do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Password confirmation can't be blank")).to be_truthy
    end

    it "is required to have an email" do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Email can't be blank")).to be_truthy
    end

    it "is required to have a first name" do
      @user.first_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("First name can't be blank")).to be_truthy
    end

    it "is required to have a last name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Last name can't be blank")).to be_truthy
    end

    it "is invalid if password != password_confirmation" do
      @user.password_confirmation = "else"
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.include?("Password confirmation doesn't match Password")).to be_truthy
    end

    it "should have a unique email" do
      @user.save
      @user2 = User.new(
        first_name: "Joe",
        last_name: "Shmoe",
        email: "Joe@shmoe.com",
        password: "test",
        password_confirmation: "test",
      )
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages.include?("Email has already been taken")).to be_truthy
    end

    it "should have case insensitive emails" do
      @user.save
      @user2 = User.new(
        first_name: "Joe",
        last_name: "Shmoe",
        email: "JOE@SHMOE.COM",
        password: "test",
        password_confirmation: "test",
      )
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages.include?("Email has already been taken")).to be_truthy
    end
  end

  describe "Password" do
    it "is greater than the minimum length"
  end
end
