# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    post :search, to: 'searches#show'
  end

  resources :remote_search, only: %i[index]

  resource :search, only: %i[show] do
    get :autocomplete, on: :collection
  end

  ActiveAdmin.routes(self)
  mount Sidekiq::Web => '/sidekiq'

  root 'home#index'
end
