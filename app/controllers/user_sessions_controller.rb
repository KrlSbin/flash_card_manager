class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to root_path, notice: I18n.t('logged_in')
    else
      flash.now[:alert] = I18n.t('login_unsuccessful')
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: I18n.t('logged_out')
  end
end
