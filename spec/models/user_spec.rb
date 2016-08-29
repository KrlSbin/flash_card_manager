# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string
#  crypted_password :string
#  created_at       :datetime
#  updated_at       :datetime
#  salt             :string
#  current_deck_id  :integer
#

require "rails_helper"

describe User, type: :model do
  context 'validations' do

    context 'simple validations' do
      it { is_expected.to validate_uniqueness_of(:email) }
      it { is_expected.to validate_length_of(:password), minimum: 3 } # probably does not work
      it { is_expected.to validate_presence_of(:password).with_message("is too short (minimum is 3 characters)") }
      it { is_expected.to validate_presence_of(:password_confirmation) }
    end

    context 'extended check' do
      shared_examples :returns_validation_message do
        it 'return validation errors' do
          expect(subject.valid?).to be false
          expect(subject.errors.messages[field][0]).to eq(message)
        end
      end

      subject { User.new(email: email, password: password, password_confirmation: password_confirmation) }

      context "when password too short" do
        let(:email) { 'kir@mail.com' }
        let(:password) { '12' }
        let(:password_confirmation) { '12' }

        it_behaves_like :returns_validation_message do
          let(:field){ :password }
          let(:message){ "is too short (minimum is 3 characters)" }
        end
      end

      context "user email already exist" do
        let(:email) { 'kir@mail.com' }
        let(:password) { 'password' }
        let(:password_confirmation) { 'password' }
        let!(:user) { User.create(email: email, password: password, password_confirmation: password_confirmation) }

        it_behaves_like :returns_validation_message do
          let(:field){ :email }
          let(:message){ "has already been taken" }
        end
      end

      context "password confirmation does not match with password" do
        let(:email) { 'kir@mail.com' }
        let(:password) { 'password' }
        let(:password_confirmation) { 'password_confirmation' }
        let!(:user) { User.create(email: email, password: password, password_confirmation: password_confirmation) }

        it_behaves_like :returns_validation_message do
          let(:field){ :password_confirmation }
          let(:message){ "doesn't match Password" }
        end
      end
    end
  end
end
