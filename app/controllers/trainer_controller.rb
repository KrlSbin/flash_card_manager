class TrainerController < ApplicationController
  def index
    @card = Card.for_review.sample
  end

  def check_translate
    @card = Card.find(params[:card_id])

    if @card.check_translation(params[:translated_text])
      flash[:notice] = "Правильно!"
    else
      flash[:notice] = "Неправильно!"
    end
    redirect_to root_path
  end
end
