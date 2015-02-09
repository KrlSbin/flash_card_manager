module Sorcery
  module TestHelpers
    module Rails
      module Integration
	def login_user(user, password)
	  visit login_path
	  fill_in "Email", with: user
	  fill_in "Password", with: password
	  click_button "Войти"
	end
      end
    end
  end
end
