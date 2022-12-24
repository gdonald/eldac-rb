# frozen_string_literal: true

FactoryBot.define do
  factory :user_project do
    user
    project
    relationship
  end
end
