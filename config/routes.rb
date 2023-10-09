# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    resource :search, only: %i[show]
  end

  resource :search, only: %i[show] do
    get :autocomplete, on: :collection
  end

  # ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'
end
