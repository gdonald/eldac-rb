# frozen_string_literal: true

Rails.application.routes.draw do
  resource :search, only: %i[show]
  root 'home#index'
end
