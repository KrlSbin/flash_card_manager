class TrainerController < ApplicationController
  def index
    if current_user.decks.empty?
      redirect_to new_deck_path
    elsif current_user.current_deck.present?
      @card = current_user.current_deck.cards.for_review.first
    else
      @card = current_user.cards.for_review.first
    end
  end

  def check_translation
    @card = Card.find(params[:card_id])

    if @card.check_translation(params[:translated_text])
      flash[:notice] = "Правильно!"
    else
      flash[:notice] = "Неправильно!"
    end
    redirect_to root_path
  end
end
