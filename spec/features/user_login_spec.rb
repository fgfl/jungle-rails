require "rails_helper"
require "pry"

RSpec.feature "Logs user in and redirects to home page", type: :feature, js: true do
  before do
    @first_name = "Olly"
    last_name = "Holly"
    @email = "Jolly@camper.com"
    @password = "Olly Holly Jolly Camper"

    User.create!(
      first_name: @first_name,
      last_name: last_name,
      email: @email,
      password: @password,
      password_confirmation: @password,
    )
  end

  scenario "User enters email and password to login form" do
    visit root_path
    expect(find("#navbar")).to have_link("Login")

    find("#navbar").click_link("Login")
    expect(page).to have_css("section.session-login > form")

    form = find("section.session-login > form")
    form.fill_in "email", with: @email
    form.fill_in "password", with: @password
    form.click_button("Sign In")

    expect(find("#navbar")).to have_content(@first_name)
    expect(page).to have_css("header.page-header > h1", text: "Products")
    # binding.pry
    save_screenshot
  end
end
