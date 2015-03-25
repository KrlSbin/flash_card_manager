require "rails_helper"

describe "Trainer page" do
  it "does not show reviewed user card" do
    user = create(:user)
    deck = user.decks.create(attributes_for(:deck))
    card = deck.cards.create(attributes_for(:card))
    card.update_attributes(review_date: Time.now + 3.days)
    login_user(user.email, "1234")
    visit root_path
    expect(page).not_to have_content card.original_text
  end

  it "show unreviewed user card" do
    user = create(:user)
    deck = user.decks.create(attributes_for(:deck))
    card = deck.cards.create(attributes_for(:card))
    card.update_attributes(user_id: user.id)
    login_user(user.email, "1234")
    visit root_path
    expect(page).to have_content card.original_text
  end

  it "show unreviewed card from current deck" do
    user = create(:user)
    login_user(user.email, "1234")
    click_link "Добавить колоду"
    fill_in "deck_name", with: "current"
    click_button "Create Deck"
    click_link "Назад"
    click_link "Добавить карту"
    fill_in "card_original_text", with: "Sea"
    fill_in "card_translated_text", with: "Море"
    click_button "Create Card"
    click_link "Назад"
    click_link "Все колоды пользователя"
    click_link "Сделать текущей"
    visit root_path
    expect(page).to have_content "Sea"
  end

  it "show unreviewed card from current deck and get incorrect translation" do
    user = create(:user)
    login_user(user.email, "1234")
    click_link "Добавить колоду"
    fill_in "deck_name", with: "current"
    click_button "Create Deck"
    click_link "Назад"
    click_link "Добавить карту"
    fill_in "card_original_text", with: "Sea"
    fill_in "card_translated_text", with: "Море"
    click_button "Create Card"
    click_link "Назад"
    click_link "Все колоды пользователя"
    click_link "Сделать текущей"
    visit root_path
    fill_in "Перевод:", with: "Мор"
    click_button "Проверить"
    expect(page).to have_content "Неправильно!"
  end

  it "show unreviewed card from current deck and get correct translation" do
    user = create(:user)
    login_user(user.email, "1234")
    click_link "Добавить колоду"
    fill_in "deck_name", with: "current"
    click_button "Create Deck"
    click_link "Назад"
    click_link "Добавить карту"
    fill_in "card_original_text", with: "Sea"
    fill_in "card_translated_text", with: "Море"
    click_button "Create Card"
    click_link "Назад"
    click_link "Все колоды пользователя"
    click_link "Сделать текущей"
    visit root_path
    fill_in "Перевод:", with: "Море"
    click_button "Проверить"
    expect(page).to have_content "Правильно!"
  end

  it "show unreviewed card from non-current deck and get correct translation" do
    user = create(:user)
    login_user(user.email, "1234")
    click_link "Добавить колоду"
    fill_in "deck_name", with: "current"
    click_button "Create Deck"
    click_link "Назад"
    click_link "Добавить карту"
    fill_in "card_original_text", with: "Sea"
    fill_in "card_translated_text", with: "Море"
    click_button "Create Card"
    visit root_path
    expect(page).to have_content "Sea"
    fill_in "Перевод:", with: "Мор"
    click_button "Проверить"
    expect(page).to have_content "Неправильно!"
    fill_in "Перевод:", with: "Море"
    click_button "Проверить"
    expect(page).to have_content "Правильно!"
  end

  it "main title presence" do
    visit root_path
    expect(page).to have_content "Флэшкарточкер"
  end
end
