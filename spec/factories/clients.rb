# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "Client #{n}" }
    requests_per_hour { 1000 }
    active { true }
  end
end
