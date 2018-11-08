require 'rails_helper'

describe 'Authentication procedure', type: :feature, js: true do
  let(:user_password) { 'password' }

  context 'existing user' do
    let!(:user) { FactoryGirl.create(:user, password: user_password, password_confirmation: user_password) }

    context 'correct credentials' do
      include_context :login_user do
        let(:password) { user_password }
      end

      it 'successful login/logout to portal' do
        expect(page).to have_content 'You are logged in!'
        click_link 'Logout'
        expect(page).to have_content 'You are logged out!'
      end
    end

    context 'invalid credentials' do
      include_context :login_user do
        let(:password) { 'some_invalid_password' }
      end

      it 'unsuccessful login to portal with wrong password' do
        expect(page).to have_content 'Login is unsuccessful'
      end
    end
  end
end
