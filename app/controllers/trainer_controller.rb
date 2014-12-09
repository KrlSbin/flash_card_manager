class TrainerController < ApplicationController
  def index
    @card = Card.old_reviewed.sample
  end

  def check_translate
    card_id = params[:card_id].to_i
    translation = params[:translated_text].to_s

    if Card.check_translate_of(card_id, translation)
      flash[:notice] = "Правильно!"
    else
      flash[:notice] = "Неправильно!"
    end
    redirect_to root_path
  end  
end
