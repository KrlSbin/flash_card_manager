require "rails_helper"

describe "Trainer page" do
  it "Reviewed user card is not shown on main page" do
    user = create(:user)
    deck = user.decks.create(attributes_for(:deck))
    card = deck.cards.create(attributes_for(:card))
    card.update_attributes(review_date: Time.now + 3.days)
    login_user(user.email, "1234")
    visit root_path
    expect(page).not_to have_content card.original_text
  end

  it "Unreviewed user card is shown on trainer page" do
    user = create(:user)
    deck = user.decks.create(attributes_for(:deck))
    card = deck.cards.create(attributes_for(:card))
    login_user(user.email, "1234")
    visit root_path
    expect(page).to have_content card.original_text
  end

  it "show user card when current deck is not set" do
    user = create(:user)
    deck = user.decks.create(attributes_for(:deck))
    card = deck.cards.create(attributes_for(:card))
    card.update_attributes(user_id: user.id)
    login_user(user.email, "1234")
    visit root_path
    expect(page).to have_content card.original_text
    deck.update_attributes(default: false)
    login_user(card.deck.user.email, "1234")
    visit root_path
    expect(page).to have_content card.original_text
    visit ("/decks/" + deck.id.to_s + "/edit")
    uncheck "deck_default"
    click_button "Update Deck"
    click_link "Назад"
    visit root_path
    expect(page).to have_content card.original_text
  end

  it "main title presence" do
    visit root_path
    expect(page).to have_content "Флэшкарточкер"
  end

  it "Add new card to current deck, show and translate it" do
    user = create(:user)
    login_user(user.email, "1234")
    visit root_path
    click_link("Добавить колоду")
    fill_in "deck_name", with: "current2"
    check "deck_default"
    click_button "Create Deck"
    click_link "Назад"
    click_link "Добавить карту"
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
    user = create(:user)
    login_user(user.email, "1234")
    visit root_path
    click_link("Добавить колоду")
    fill_in "deck_name", with: "current2"
    click_button "Create Deck"
    click_link "Назад"
    click_link "Добавить карту"
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
end
