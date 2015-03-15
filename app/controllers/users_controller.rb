class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        auto_login(@user)
        format.html { redirect_to root_path, notice: "Пользователь создан." }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to current_user, notice: "Профиль обновлен." }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "Пользователь удален." }
      format.json { head :no_content }
    end
  end

  def set_current_deck
    current_user.set_current_deck(params[:deck_id])
    render "decks/index"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :authentications_attributes, :current_deck_id)
  end
end
