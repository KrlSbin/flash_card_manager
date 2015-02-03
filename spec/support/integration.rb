module Sorcery
  module TestHelpers
    module Rails
      module Integration
	def login_user(user, password)
	  fill_in "Email", with: user
	  fill_in "Password", with: password
	  click_button "Login"
	end
      end
    end
  end
end
