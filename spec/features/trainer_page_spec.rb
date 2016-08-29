require "rails_helper"

describe "Trainer page", type: :feature, js: true do
  let(:password) { "password" }
  let!(:user) { FactoryGirl.create(:user, password: password, password_confirmation: password) }

  it "does not show reviewed user card" do
    deck = user.decks.create(attributes_for(:deck))
    card = deck.cards.create(attributes_for(:card))
    card.update_attributes(review_date: Time.now + 3.days)
    login_user(user.email, password)
    visit root_path
    expect(page).not_to have_content card.original_text
  end

  it 'show unreviewed user card' do
    deck = user.decks.create(attributes_for(:deck))
    card = deck.cards.create(attributes_for(:card))
    card.update_attributes(user_id: user.id)
    login_user(user.email, password)
    visit root_path
    expect(page).to have_content card.original_text
  end

  it "show unreviewed card from current deck" do
    login_user(user.email, password)
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

  it "show unreviewed card from current deck and put typo in translation" do
    login_user(user.email, password)
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
    expect(page).to have_content "Очепятка!"
  end

  it "show unreviewed card from current deck and put wrong translation" do
    login_user(user.email, password)
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
    fill_in "Перевод:", with: "Моречко"
    click_button "Проверить"
    expect(page).to have_content "Неправильно!"
  end

  it "show unreviewed card from current deck and get correct translation" do
    login_user(user.email, password)
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

  it "show unreviewed card from non-current deck and put right translation" do
    login_user(user.email, password)
    click_link "Добавить колоду"
    fill_in "deck_name", with: "current"
    click_button "Create Deck"
    click_link "Назад"
    click_link "Добавить карту"
    fill_in "card_original_text", with: "Sea"
    fill_in "card_translated_text", with: "Море"
    click_button "Create Card"
    visit root_path
    fill_in "Перевод:", with: "Море"
    click_button "Проверить"
    expect(page).to have_content "Правильно!"
  end

  it "show unreviewed card from non-current deck and typo in translation" do
    login_user(user.email, password)
    click_link "Добавить колоду"
    fill_in "deck_name", with: "current"
    click_button "Create Deck"
    click_link "Назад"
    click_link "Добавить карту"
    fill_in "card_original_text", with: "Sea"
    fill_in "card_translated_text", with: "Море"
    click_button "Create Card"
    visit root_path
    fill_in "Перевод:", with: "Моер"
    click_button "Проверить"
    expect(page).to have_content "Очепятка!"
  end

  it "main title presence" do
    visit root_path
    expect(page).to have_content "Флэшкарточкер"
  end
end
