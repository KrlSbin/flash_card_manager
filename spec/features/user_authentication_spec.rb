require "rails_helper"

describe "Authentication procedure" do
  it "successful login/logout to portal" do
    user = create(:user)
    login_user(user.email, "1234")
    expect(page).to have_content "Вы залогинены"
    click_link "Выйти"
    expect(page).to have_content "Вы вышли!"
  end

  it "unsuccessful login to portal with wrong password" do
    user = create(:user)
    login_user(user.email, "123")
    expect(page).to have_content "Логин неудался"
  end

  it "successful new user registration and autologin" do
    visit root_path
    click_link "Регистрация"
    fill_in "Email", with: "1234"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_button "Create User"
    expect(page).to have_content "Пользователь создан."
  end

  it "unsuccessful new user registration with short password" do
    visit root_path
    click_link "Регистрация"
    fill_in "Email", with: "1234"
    fill_in "Password", with: "12"
    fill_in "Password confirmation", with: "12"
    click_button "Create User"
    expect(page).to have_content "Password is too short"
  end

  it "unsuccessful new user registration with already used email" do
    visit root_path
    click_link "Регистрация"
    fill_in "Email", with: "1234"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_button "Create User"
    click_link "Выйти"
    click_link "Регистрация"
    fill_in "Email", with: "1234"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_button "Create User"
    expect(page).to have_content "Email has already been taken"
  end

  it "unsuccessful new user registration with empty password" do
    visit root_path
    click_link "Регистрация"
    fill_in "Email", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_button "Create User"
    expect(page).to have_content "Password is too short"
  end

  it "unsuccessful new user registration with empty password confirmation" do
    visit root_path
    click_link "Регистрация"
    fill_in "Email", with: "1234"
    fill_in "Password", with: "1234"
    click_button "Create User"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it "Usuccessful new user registration with wrong password confirmation" do
    visit root_path
    click_link "Регистрация"
    fill_in "Email", with: "1234"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "12345"
    click_button "Create User"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end
end
