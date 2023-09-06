# frozen_string_literal: true

Rails.application.routes.draw do
  resource :search, only: %i[show]

  mount GoodJob::Engine => 'good_job'
  ActiveAdmin.routes(self)

  root 'home#index'
end
