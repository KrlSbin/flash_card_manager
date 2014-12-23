require "spec_helper"

describe "index page content", type: :feature do
  it "main title presence" do
    visit "/"
    expect(page).to have_content "Флэшкарточкер"
  end
end
