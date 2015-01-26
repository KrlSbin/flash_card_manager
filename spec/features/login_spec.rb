require "rails_helper"

describe "Authentication procedures" do
  it "Successful login to portal" do
    create(:card, original_text: "card")
    puts card.user.email
    puts card.user.password
    visit login_path
    fill_in "Email", with: card.user.email
    fill_in "Password", with: card.user.password
    click_button "Login"
    expect(page).to have_content "Login successful"
   end
end

