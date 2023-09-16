# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |_repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'aasm', '~> 5.5.0'
gem 'activeadmin', '~> 3.0.0'
gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap5-kaminari-views', '~> 0.0.1'
gem 'cssbundling-rails', '~> 1.2'
gem 'dotenv-rails', '~> 2.8.1'
gem 'httparty', '~> 0.21.0'
gem 'importmap-rails', '~> 1.2.1'
gem 'jbuilder'
gem 'jsbundling-rails', '~> 1.1'
gem 'kaminari', '~> 1.2.2'
gem 'nokogiri', '~> 1.15.4'
gem 'pg', '~> 1.1'
gem 'pg_search', '~> 2.3.6'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.7', '>= 7.0.7.2'
gem 'redis', '~> 5.0.7'
gem 'sassc'
gem 'sidekiq', '~> 7.1.4'
gem 'sidekiq-cron', '~> 1.10.1'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

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
  gem 'simplecov', require: false
end
