class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :destroy, :update]

  def index
    @cards = current_user.cards
  end

  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.new(card_params)

    if @card.save
      redirect_to @card
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @card.destroy

    redirect_to cards_path
  end

  def update
    if @card.update(card_params)
      redirect_to @card
    else
      render "edit"
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end

  def set_card
    @card = current_user.cards.find(params[:id])
  end
end
