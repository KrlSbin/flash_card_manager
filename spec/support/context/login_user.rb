shared_context :login_user do
  before { login_user(user.email, password) }
end
