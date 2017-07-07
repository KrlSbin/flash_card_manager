desc 'This task is called by the Heroku scheduler add-on'
task mail_card_to_review: :environment do
  puts 'Sending emails...'
  Card.mail_cards_to_review
  puts 'done.'
end