# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    project
    name { 'Survey 1' }
    active { false }
  end
end
