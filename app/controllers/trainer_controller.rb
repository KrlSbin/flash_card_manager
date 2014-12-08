class TrainerController < ApplicationController
  def index
    @card = Card.where("review_date <= ?", Time.now).sample
  end

  def check_translate
    if params[:translated_text] == params[:correct_translation]
      @card = Card.find(params[:card_id])
      @card.update_attribute(:review_date, Time.now + 3.days)
      flash[:notice] = "Правильно! "
    else
      flash[:notice] = "Не правильно!"
    end
    redirect_to '/'
  end
end
