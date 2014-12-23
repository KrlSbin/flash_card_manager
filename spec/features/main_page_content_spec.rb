require "spec_helper"

describe "main page content", type: :feature do
  it "Reviewed card is not shown on main page" do
    card = create(:card, original_text: "card")
    card.review_date = Time.now + 3.days
    card.save
    visit "/"
    expect(page).not_to have_content card.original_text
  end

  it "Unreviewed card is shown on main page" do
    create(:card, original_text: "card")
    visit "/"
    expect(page).to have_content "card"
  end
end
