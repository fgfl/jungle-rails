require "rails_helper"
require "product"

RSpec.describe Product, type: :model do
  describe "Validations" do
    before(:each) do
      @category = Category.new(name: "junk")
      @category.save
    end

    it "should create a valid product with all proper fields set" do
      @product = Product.new({
        name: "test product",
        price: 234234,
        quantity: 5757,
        category_id: @category[:id],
      })
      expect(@product).to be_valid
    end

    it "should have a name" do
      @product = Product.new({
        name: nil,
        price: 234234,
        quantity: 5757,
        category_id: @category[:id],
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.include?("Name can't be blank")).to be_truthy
    end

    it "should have a price" do
      @product = Product.new({
        name: "test product",
        price: nil,
        quantity: 5757,
        category_id: @category[:id],
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.include?("Price cents is not a number")).to be_truthy
    end

    it "should have a quantity" do
      @product = Product.new({
        name: "test product",
        price: 234234,
        quantity: nil,
        category_id: @category[:id],
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.include?("Quantity can't be blank")).to be_truthy
    end

    it "should have a category" do
      @product = Product.new({
        name: "test product",
        price: 234234,
        quantity: 5757,
        category_id: nil,
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.include?("Category can't be blank")).to be_truthy
    end
  end
end
