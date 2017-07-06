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
    check_result = @card.check_translation(params[:translated_text])

    if check_result[:success]
      flash[:notice] = 'Правильно!'
    elsif check_result[:typos_count] == 1
      flash[:notice] = "Очепятка! \
                        Вы ввели #{params[:translated_text]}. \
                        Правильный перевод \"#{@card.original_text}\" \
                        - \"#{@card.translated_text}\"!"
    else
      flash[:notice] = 'Неправильно!'
    end
    redirect_to root_path
  end
end
