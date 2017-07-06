shared_context :user do
  before { @user = FactoryGirl.create(:user) }
end