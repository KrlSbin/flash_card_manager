every 1.day do
  runner 'Card.mail_cards_to_review', output: 'log/cron.log'
end
