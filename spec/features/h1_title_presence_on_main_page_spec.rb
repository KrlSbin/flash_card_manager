require "capybara/rspec"

describe "open index page", type: :feature do
  it "h1 presence on main page" do
    visit "/"
    expect(page).to have_content "Флэшкарточкер"
  end
end
