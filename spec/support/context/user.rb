shared_context :user do
  before { @user = FactoryBot.create(:user) }
end