require 'rails_helper'

describe 'Trainer page', type: :feature, js: true do
  before { @user = FactoryBot.create(:user, password: 'password', password_confirmation: 'password') }

  context 'cards visibility' do

    context 'simple check' do
      before do
        @card = FactoryBot.create(:card, :with_deck, user: @user)
        @card.update(review_date: review_date)
        @user.decks << @card.deck
        @user.update(current_deck_id: @card.deck.id)
        login_user(@user.email, 'password')
        visit root_path
      end

      context 'already reviewed card' do
        let(:review_date) { Time.now + 3.days }
        it 'is not shown' do
          # check if correct the page is opened at all
          expect(page).to have_content 'Flashcard manager'
          expect(page).not_to have_content @card.original_text
          expect(page).to have_content 'There are no new cards'
        end
      end

      context 'new not reviewed card' do
        let(:review_date) { Time.now }

        it 'is shown' do
          expect(page).to have_content @card.original_text
        end

        it 'put typo in translation' do
          fill_in 'Translation:', with: 'мор'
          click_button 'Check'
          expect(page).to have_content 'Typo!'
        end

        it 'show unreviewed card from current deck and put wrong translation' do
          fill_in 'Translation:', with: 'моречко'
          click_button 'Check'
          expect(page).to have_content 'Incorrect!'
        end

        it 'show unreviewed card from current deck and get correct translation' do
          fill_in 'Translation:', with: 'море'
          click_button 'Check'
          expect(page).to have_content 'Correct!'
        end
      end
    end
  end

  context 'main title' do
    it 'main title presence' do
      visit root_path
      expect(page).to have_content 'Flashcard manager.'
    end
  end
end
