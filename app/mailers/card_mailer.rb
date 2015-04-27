class CardMailer < ActionMailer::Base
  default from: 'goldpatch@mail.ru'

  def cards_to_review(user)
    @user = user
    @url = 'https://flashcardmanage.herokuapp.com/'
    mail(to: @user.email, subject: 'You have new cards for review!')
  end
end
