# == Schema Information
#
# Table name: cards
#
#  id                      :integer          not null, primary key
#  original_text           :text
#  translated_text         :text
#  review_date             :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  user_id                 :integer          indexed
#  deck_id                 :integer          indexed
#  box_number              :integer
#  attempt                 :integer
#
# Indexes
#
#  index_cards_on_deck_id  (deck_id)
#  index_cards_on_user_id  (user_id)
#

require 'rails_helper'

describe Card, type: :model do

  let(:original_text) { 'Word' }
  let(:translated_text) { 'Слово' }

  describe 'validations' do
    before { @card = FactoryBot.build(:card, :with_deck, original_text: original_text, translated_text: translated_text) }

    shared_examples :valid do
      it 'is valid' do
        expect(@card.valid?).to be_truthy
      end
    end

    shared_examples :not_valid do
      it 'is not valid' do
        expect(@card.valid?).to be_falsey
      end
    end

    context 'when original and translated words are identical' do
      let(:translated_text) { original_text }

      it_behaves_like :not_valid
    end

    context 'when original and translated text fields are different' do
      let(:translated_text) { 'Слово' }

      it_behaves_like :valid
    end
  end

  describe '#check_translation' do
    let!(:card) { FactoryBot.create(:card, :with_deck, original_text: original_text, translated_text: translated_text) }

    let!(:original_review_date) { card.review_date }

    subject { card.reload.check_translation(check_translation_word) }

    shared_examples :update_review_date do
      let(:time_offset) { 0.seconds }

      it 'updates review date' do
        subject
        # 3600 seconds shift because of winter/summer time
        expect(card.review_date).to be_within(3610).of(original_review_date + time_offset)
      end
    end

    context 'positive translation' do
      let(:check_translation_word) { 'Слово' }

      shared_examples :inc_box_number do
        it 'increment box number' do
          expect { subject }.to change { card.box_number }.by(1)
        end
      end

      it 'should return success true' do
        expect(card.check_translation(check_translation_word)[:success]).to be true
      end

      context 'when card in box 1' do
        before { card.update_attributes(box_number: 1) }

        it_behaves_like :update_review_date do
          let(:time_offset) { 12.hours }
        end

        it_behaves_like :inc_box_number
      end

      context 'when card in box 2' do
        before { card.update_attributes(box_number: 2) }

        it_behaves_like :update_review_date do
          let(:time_offset) { 3.days }
        end

        it_behaves_like :inc_box_number
      end

      context 'when card in box 3' do
        before { card.update_attributes(box_number: 3) }

        it_behaves_like :update_review_date do
          let(:time_offset) { 7.days }
        end

        it_behaves_like :inc_box_number
      end

      context 'when card in box 4' do
        before { card.update_attributes(box_number: 4) }

        it_behaves_like :update_review_date do
          let(:time_offset) { 14.days }
        end

        it_behaves_like :inc_box_number
      end

      context 'when card in box 5' do
        before { card.update_attributes(box_number: 5) }

        it_behaves_like :update_review_date do
          let(:time_offset) { 1.month }
        end

        it_behaves_like :inc_box_number
      end

      context 'when card in box 6' do
        before { card.update_attributes(box_number: 6) }

        it_behaves_like :update_review_date do
          let(:time_offset) { 1.month }
        end

        it 'should not update box number' do
          expect { subject }.not_to change { card.box_number }
        end
      end
    end

    context 'incorrect translation' do
      let(:check_translation_word) { 'Словечки' }

      it 'should return success false' do
        expect(subject[:success]).to be false
      end

      it 'should increment attempt attempt count' do
        expect { subject }.to change { card.attempt }.by(1)
      end

      it 'should not update review date' do
        expect { subject }.not_to change { card.review_date.to_s(:db) }
      end

      context 'after 3 fail attempts' do
        before { card.update(attempt: 2) }

        it_behaves_like :update_review_date do
          let(:time_offset) { 12.hours }
        end

        it 'reset attempt field to zero' do
          subject
          expect(card.attempt).to eql(0)
        end
      end
    end
  end

  describe '.mail_cards_to_review' do
    include_context :user

    before { @card = FactoryBot.create(:card, :with_deck, original_text: original_text, translated_text: translated_text, user: @user) }

    subject { Card.mail_cards_to_review }

    it 'send notification about new card to review' do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
