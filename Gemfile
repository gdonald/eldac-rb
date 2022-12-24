source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

gem 'activeadmin', '~> 2.13.1'
gem 'factory_bot_rails', '~> 6.2.0'
gem 'jquery-rails', '~> 4.5.1'
gem 'kaminari', '~> 1.2.2'
gem 'rails', '~> 7.0.4'
gem 'sprockets-rails'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0.1'
gem 'jsbundling-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'cssbundling-rails'
gem 'jbuilder'
gem 'bcrypt', '~> 3.1.7'
gem 'sassc-rails'

group :development, :test do
  gem 'brakeman', '~> 5.4.0'
  gem 'bundler-audit'
  gem 'faker'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end

group :development do
  gem 'capistrano', '~> 3.17.1', require: false
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'simplecov', require: false
  gem 'webdrivers', '~> 5.2.0', require: false
end
