require "rails_helper"
require "pry"

RSpec.feature "Visitor views product details", type: :feature, js: true do
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset("apparel1.jpg"),
        quantity: 10,
        price: 64.99,
      )
    end
  end

  scenario "by clicking the product header" do
    visit root_path

    header = page.first("article.product > header")
    header.click

    expect(page).to have_link("Apparel")
  end

  scenario "by clicking the details button" do
    visit root_path

    detail_button = page.first("article.product").find_link("Details")
    detail_button.click

    expect(page).to have_link("Apparel")
  end
end
