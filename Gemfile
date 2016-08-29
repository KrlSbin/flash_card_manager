source 'https://rubygems.org'

gem 'rails', '~> 4.2'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'execjs'
gem 'therubyracer'
gem 'simple_form'
gem 'sorcery', '~> 0.9.0'
gem 'figaro'
gem 'paperclip'
gem 'aws-sdk', '< 2.0'
gem 'posix-spawn'
gem 'damerau-levenshtein', '~> 1.0.3'
gem 'whenever', :require => false

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'travis-lint'
  gem 'database_cleaner'
  gem 'debase'
  gem 'debase-ruby_core_source'
  gem 'annotate'
end

group :development do
  gem 'spring'
  gem 'ruby-debug-ide'
end

group :test do
  gem 'connection_pool'
  gem 'capybara'
  gem 'poltergeist'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'selenium-webdriver'
end

gem "codeclimate-test-reporter", group: :test, require: nil