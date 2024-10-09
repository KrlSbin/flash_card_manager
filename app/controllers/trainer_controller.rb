class TrainerController < ApplicationController
  def index
    redirect_to new_deck_path if current_user.decks.empty?

    @card = if current_user.current_deck.present?
              current_user.current_deck.cards.for_review.first
            else
              current_user.cards.for_review.first
            end
  end

  def check_translation
    @card = Card.find(params[:card_id])
    check_result = @card.check_translation(params[:translated_text])

    flash[:notice] = if check_result[:success]
                       I18n.t('correct')
                     elsif check_result[:typos_count] == 1
                       I18n.t('typo',
                              translation: params[:translated_text],
                              original_text: @card.original_text,
                              translated_text: @card.translated_text)
                     else
                       I18n.t('incorrect')
                     end

    redirect_to root_path
  end
end
