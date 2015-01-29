require "rails_helper"

describe "Authentication procedures" do
  it "Successful login to portal" do
    user = create(:user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "1234" 
    click_button "Login"
    expect(page).to have_content "Login successful"
   end
end

