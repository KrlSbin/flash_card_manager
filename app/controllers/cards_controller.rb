class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :destroy, :update]

  def index
  end

  def new
    @deck = current_user.decks.find(params[:deck_id])
    @card = @deck.cards.new
  end

  def create
    @deck = current_user.decks.find(params[:deck_id])
    @card = @deck.cards.new(card_params)
    @card.user_id = params[:user_id]

    if @card.save
      redirect_to [@deck, @card]
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

    redirect_to deck_cards_path
  end

  def update
    if @card.update(card_params)
      redirect_to [@deck, @card]
    else
      render "edit"
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text,
                                 :review_date, :card_photo, :deck_id, :user_id)
  end

  def set_card
    @deck = current_user.decks.find(params[:deck_id])
    @card = @deck.cards.find(params[:id])
  end
end
