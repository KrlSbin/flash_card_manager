require "rails_helper"

describe "main page content" do
  it "Reviewed card is not shown on main page" do
    card = create(:card, original_text: "card")
    card.review_date = Time.now + 3.days
    card.save
    visit root_path
    expect(page).not_to have_content card.original_text
  end

  it "Unreviewed card is shown on main page" do
    create(:card, original_text: "card")
    visit root_path
    expect(page).to have_content "card"
  end

  it "main title presence" do
    visit root_path
    expect(page).to have_content "Флэшкарточкер"
  end
end
