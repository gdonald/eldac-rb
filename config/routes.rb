# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resource :search, only: %i[show]

  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'
end
