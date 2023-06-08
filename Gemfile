source 'https://rubygems.org'

ruby '3.2.2'

gem 'bundler', '2.4.13'

gem 'codeclimate-test-reporter', group: :test, require: nil
gem 'coffee-rails'
gem 'damerau-levenshtein', '~> 1.0.3'
gem 'execjs'
gem 'figaro'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'pg'
gem 'posix-spawn'
gem 'rails'
gem 'sass-rails'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'simple_form'
gem 'sorcery', '~> 0.9.0'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'whenever', require: false

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'annotate'
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'travis-lint'
end

group :development do
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'connection_pool'
  gem 'factory_bot'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: true
end
