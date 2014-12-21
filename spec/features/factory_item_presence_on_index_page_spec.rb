require "capybara/rspec"
require "spec_helper"

describe "factory item presence", type: :feature do
  it "factory item presence on index page" do
    create(:card)
    visit "/"
    click_link("Все карточки")
    expect(page).to have_content "карточка"
  end
end
