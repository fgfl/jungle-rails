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
    it "is greater than the minimum length" do
      @user = User.new(
        first_name: "Joe",
        last_name: "Shmoe",
        email: "Joe@shmoe.com",
        password: "a",
        password_confirmation: "a",
      )
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.any? { |err| err.include?("Password is too short") }).to be_truthy
    end
  end

  describe ".authenticate_with_credentials" do
    before(:each) do
      @user = User.create(
        first_name: "Joe",
        last_name: "Shmoe",
        email: "JOE@SHMOE.COM",
        password: "test",
        password_confirmation: "test",
      )
    end

    it "should return a User instance for viable login" do
      user = User.authenticate_with_credentials("JOE@SHMOE.COM", "test")
      expect(user).to be_kind_of User
    end

    it "should return nil for invalid email" do
      user = User.authenticate_with_credentials("no@SHMOE.COM", "test")
      expect(user).to be_nil
    end

    it "should return nil for invalid password" do
      user = User.authenticate_with_credentials("JOE@SHMOE.COM", "wrongPassword")
      expect(user).to be_nil
    end

    it "should return a User if the entered email has leading or ending spaces" do
      user = User.authenticate_with_credentials(" JOE@SHMOE.COM ", "test")
      expect(user).to be_kind_of User
    end

    it "should return a User if the entered email is in the wrong case" do
      user = User.authenticate_with_credentials("JoE@ShmOe.Com", "test")
      expect(user).to be_kind_of User
    end
  end
end
