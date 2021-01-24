# frozen_string_literal: true

ruby '2.7.2'

source 'https://rubygems.org'

gem 'actionpack', '>= 6.0.3.2'
gem 'activerecord-session_store'
gem 'acts_as_list'
gem 'bcrypt'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'factory_bot_rails'
gem 'haml'
gem 'jbuilder'
gem 'jquery-rails'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'sass-rails'
gem 'simple_form'
gem 'sprockets-rails'
gem 'uglifier'

group :development, :test do
  gem 'byebug'
  gem 'faker'
  gem 'pry'

  # TODO: remove this:
  # %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
  #   gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'master'
  # end

  # TODO: add this back:
  gem 'rspec-rails'

  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'wirble'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara-selenium'
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
