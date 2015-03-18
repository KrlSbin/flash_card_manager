class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :destroy, :update]
  before_action :set_deck, only: [:new, :create]

  def index
  end

  def new
    @card = @deck.cards.new
    @card.user_id = current_user.id
  end

  def create
    @card = @deck.cards.new(card_params)
    @card.user_id = current_user.id

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

  def set_deck
    @deck = current_user.decks.find(params[:deck_id])
  end

  def set_card
    set_deck
    @card = @deck.cards.find(params[:id])
  end
end
