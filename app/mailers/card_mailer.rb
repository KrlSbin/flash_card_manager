class CardMailer < ActionMailer::Base
  default from: ENV["MAILER_ADDR"]
  def cards_to_review(user)
    @user = user
    mail(to: @user.email, subject: "You have new cards for review!")
  end
end
