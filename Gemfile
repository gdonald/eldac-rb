# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |_repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bcrypt', '~> 3.1.7'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.7', '>= 7.0.7.2'
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'

# gem 'sassc-rails'
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'debug'
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'pry'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'shoulda-matchers', '~> 5.3.0'
end
