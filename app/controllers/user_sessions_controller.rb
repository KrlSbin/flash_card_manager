class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to root_path, notice: "Вы залогинены"
    else
      flash.now[:alert] = "Логин неудался"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "Вы вышли!"
  end
end
