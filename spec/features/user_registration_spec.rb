require 'rails_helper'

describe 'User Registration', type: :feature, js: true do
  let(:short_password) { '12' }
  let(:user_password) { 'password' }
  let(:user_email) { 'user_email@mail.com' }

  context 'new user registration' do
    before { visit root_path }

    context 'positive user case' do
      subject { click_button 'Create User' }

      it 'successful new user registration and autologin' do
        click_link 'Регистрация'
        fill_in 'Email', with: user_email
        fill_in 'Password', with: user_password
        fill_in 'Password confirmation', with: user_password
        expect { subject }.to change { User.count }.by(1)
        expect(page).to have_content 'Пользователь создан.'
      end
    end

    context 'unsuccessful create' do
      context 'with short password' do
        it 'unsuccessful new user registration with short password' do
          click_link 'Регистрация'
          fill_in 'Email', with: user_email
          fill_in 'Password', with: short_password
          fill_in 'Password confirmation', with: short_password
          click_button 'Create User'
          expect(page).to have_content 'Password is too short'
        end
      end

      context 'when user already created' do
        let!(:user) do
          FactoryGirl.create(:user, email: user_email,
                             password: user_password,
                             password_confirmation: user_password)
        end

        it 'unsuccessful new user registration with already used email' do
          click_link 'Регистрация'
          fill_in 'Email', with: user_email
          fill_in 'Password', with: user_password
          fill_in 'Password confirmation', with: user_password
          click_button 'Create User'
          expect(page).to have_content 'Email has already been taken'
        end
      end

      context 'when password field empty' do
        it 'unsuccessful new user registration with empty password' do
          click_link 'Регистрация'
          fill_in 'Email', with: '1234'
          fill_in 'Password confirmation', with: '1234'
          click_button 'Create User'
          expect(page).to have_content 'Password is too short'
        end
      end

      context 'password confirmation field' do
        let(:validation_message) { "Password confirmation doesn't match Password" }

        context 'empty password confimation' do
          it 'Fail new user registration with empty password confirmation' do
            click_link 'Регистрация'
            fill_in 'Email', with: '1234'
            fill_in 'Password', with: '1234'
            click_button 'Create User'
            expect(page).to have_content validation_message
          end
        end

        context 'wrong password confirmation' do
          it 'Failed new user registration with wrong password confirmation' do
            click_link 'Регистрация'
            fill_in 'Email', with: '1234'
            fill_in 'Password', with: '1234'
            fill_in 'Password confirmation', with: '12345'
            click_button 'Create User'
            expect(page).to have_content validation_message
          end
        end
      end

    end
  end
end
