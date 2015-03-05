require "rails_helper"

describe "Decks links and current state." do
  it "all cards link is not shown after user registration" do
    user = create(:user)
    login_user(user.email, "1234")
    expect(page).not_to have_content "Все карточки пользователя"
  end

  it "all decks link is not shown after user registration" do
    user = create(:user)
    login_user(user.email, "1234")
    expect(page).not_to have_content "Все колоды пользователя"
  end

  it "add new deck link is shown after user registration" do
    user = create(:user)
    login_user(user.email, "1234")
    expect(page).to have_content "Добавить колоду"
  end

  it "only one deck could be created as current" do
    user = create(:user)
    user.decks.create(attributes_for(:deck))
    login_user(user.email, "1234")
    click_link("Добавить колоду")
    fill_in "deck_name", with: "current2"
    check "deck_default"
    click_button "Create Deck"
    expect(page).to have_content "Default has already been taken"
  end
 
  it "Only one deck could be updated as current" do
    user = create(:user)
    user.decks.create(attributes_for(:deck))
    non_current_deck = user.decks.create(name: "non current", default: false)
    login_user(user.email, "1234")
    visit ("/decks/" + non_current_deck.id.to_s + "/edit")
    check "deck_default"
    click_button "Update Deck"
    expect(page).to have_content "Default has already been taken"
  end
end
