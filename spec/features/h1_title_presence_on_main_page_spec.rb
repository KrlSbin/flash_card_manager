require "capybara/rspec"

describe "open index page", type: :feature do
  it "open index page" do
    visit "/"
    expect(page).to have_content 'Флэшкарточкер'
  end
end
