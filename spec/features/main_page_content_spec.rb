require "rails_helper"

describe "Trainer page" do
  it "Reviewed user card is not shown on main page" do
    card = create(:card)
    card.update_attributes(review_date: Time.now + 3.days)
    login_user(user.email, "1234")
    visit root_path
    expect(page).not_to have_content card.original_text
  end

  it "Unreviewed user card is shown on trainer page" do
    card = create(:card)
    login_user(user.email, "1234")
    visit root_path
    expect(page).to have_content card.original_text
  end

  it "Reviewed card from current deck is not shown on trainer page" do
    pending
  end

  it "Unreviewed card from current deck is shown on trainer page" do
    pending
  end

  it "main title presence" do
    visit root_path
    expect(page).to have_content "Флэшкарточкер"
  end

  it "Add new card to current deck, show and translate it" do
    deck = create(:deck)
    login_user(deck.user.email, "1234")
    visit root_path
    click_link("Все колоды пользователя")
    click_link("Добавить карту")
    fill_in "card_original_text", with: "Sea"
    fill_in "card_translated_text", with: "Море"
    click_button "Create Card"
    visit root_path
    fill_in "Перевод:", with: "Мор"
    click_button "Проверить"
    expect(page).to have_content "Неправильно!"
    fill_in "Перевод:", with: "Море"
    click_button "Проверить"
    expect(page).to have_content "Правильно!"
  end

  it "Add new card to non current deck, show and translate it" do
    pending
  end
end
