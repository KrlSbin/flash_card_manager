require "capybara/rspec"
require "spec_helper"

describe "index page content", type: :feature do
  it "factory item presence" do
    create(:card)
    visit "/"
    click_link("Все карточки")
    expect(page).to have_content "карточка"
  end

  it "main title presence" do
    visit "/"
    expect(page).to have_content "Флэшкарточкер"
  end
end
