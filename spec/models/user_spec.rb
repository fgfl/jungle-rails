require "rails_helper"

RSpec.describe User, type: :model do
  describe "Validations:" do
    it "the user is valid with proper fields" do
      @user = User.new(
        first_name: "Joe",
        last_name: "Shmoe",
        email: "Joe@shmoe.com",
        password: "test",
        password_confirmation: "test",
      )
      # raise @user.inspect
      expect(@user).to be_valid
    end
  end
end
