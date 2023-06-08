require 'rails_helper'

describe CardMailer do
  subject { ActionMailer::Base.deliveries }

  let(:password) { 'password' }
  let!(:user) { FactoryBot.create(:user, password: password, password_confirmation: password) }

  before do
    user.cards.create(original_text: 'Word', translated_text: 'Слово',
                      deck_id: 1)
    CardMailer.cards_to_review(user).deliver_now
  end

  after (:each) do
    ActionMailer::Base.deliveries.clear
  end

  context '#cards_to_review' do
    it 'should send an email' do
      expect(subject.count).to eq(1)
    end

    it 'renders the receiver email' do
      expect(subject.first.to).to eq([user.email])
    end

    it 'should set the correct subject' do
      expect(subject.first.subject).to eq('You have new cards for review!')
    end

    it 'renders the sender email' do
      expect(subject.first.from).to eq([ENV['MAILER_ADDR']])
    end
  end
end
