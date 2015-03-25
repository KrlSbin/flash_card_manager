class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :destroy, :update]

  def new
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.new(deck_params)

    if @deck.save
      redirect_to @deck
    else
      render "new"
    end
  end

  def show
  end

  def index
    @decks = current_user.decks.all
  end

  def destroy
    @deck.destroy

    redirect_to decks_path
  end

  def edit
  end

  def update
    if @deck.update(deck_params)
      redirect_to @deck
    else
      render "edit"
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end

  def set_deck
    @deck = current_user.decks.find(params[:id])
  end
end
