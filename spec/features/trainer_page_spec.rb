require "rails_helper"

describe "Trainer page", type: :feature, js: true do
  before { @user = FactoryGirl.create(:user, password: 'password', password_confirmation: 'password') }

  context "cards visibility" do

    context 'simple check' do
      before do
        @card = FactoryGirl.create(:card, :with_deck, user: @user)
        @card.update(review_date: review_date)
        @user.decks << @card.deck
        @user.update(current_deck_id: @card.deck.id)
        login_user(@user.email, 'password')
        visit root_path
      end

      context "already reviewed card" do
        let(:review_date) { Time.now + 3.days }
        it "is not shown" do
          # check if correct the page is opened at all
          expect(page).to have_content "Flashcard manager."
          expect(page).not_to have_content @card.original_text
          expect(page).to have_content "Новых карточек нет."
        end
      end

      context "new not reviewed card" do
        let(:review_date) { Time.now }

        it 'is shown' do
          expect(page).to have_content @card.original_text
        end

        it "put typo in translation" do
          fill_in "Перевод:", with: "мор"
          click_button "Проверить"
          expect(page).to have_content "Очепятка!"
        end

        it "show unreviewed card from current deck and put wrong translation" do
          fill_in "Перевод:", with: "моречко"
          click_button "Проверить"
          expect(page).to have_content "Неправильно!"
        end

        it "show unreviewed card from current deck and get correct translation" do
          fill_in "Перевод:", with: "море"
          click_button "Проверить"
          expect(page).to have_content "Правильно!"
        end
      end
    end
  end

  context "main title" do
    it "main title presence" do
      visit root_path
      expect(page).to have_content "Flashcard manager."
    end
  end
end
