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
      @product.save
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it "should have a price" do
      @product = Product.new({
        name: "test product",
        price: nil,
        quantity: 5757,
        category_id: @category[:id],
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to eq("Price cents is not a number")
    end

    it "should have a quantity" do
      @product = Product.new({
        name: "test product",
        price: 234234,
        quantity: nil,
        category_id: @category[:id],
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
    end

    it "should have a category" do
      @product = Product.new({
        name: "test product",
        price: 234234,
        quantity: 5757,
        category_id: nil,
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to eq("Category can't be blank")
    end
  end
end
