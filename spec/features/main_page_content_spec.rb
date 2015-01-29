require "rails_helper"

describe "main page content" do
  it "Reviewed card is not shown on main page" do
    card = create(:card, original_text: "card")
    card.update_attributes(review_date: Time.now + 3.days)
    visit login_path
    login_user_post(card.user.email, "1234")
    visit root_path
    expect(page).not_to have_content card.original_text
  end

  it "Unreviewed card is shown on main page" do
    card = create(:card, original_text: "card")
    visit login_path
    login_user_post(card.user.email, "1234")
    visit root_path
    expect(page).to have_content card.original_text
  end

  it "main title presence" do
    visit root_path
    expect(page).to have_content "Флэшкарточкер"
  end

  it "Add new card and translate it" do
    user = create(:user)
    visit login_path
    login_user_post(user.email, "1234")
    visit root_path
    click_link("Добавить карточку")
    fill_in "Original text", with: "Sea"
    fill_in "Translated text", with: "Море"
    click_button "Create Card"
    visit root_path
    fill_in "Translated text", with: "Мор"
    click_button "Проверить"
    expect(page).to have_content "Неправильно!"
    fill_in "Translated text", with: "Море"
    click_button "Проверить"
    expect(page).to have_content "Правильно!"
  end
end
