# frozen_string_literal: true

FactoryBot.define do
  factory :server do
    sequence(:name) { |n| "Server #{n}" }
    requests_per_hour { 1000 }
    active { true }
  end
end
