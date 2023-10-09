# frozen_string_literal: true

FactoryBot.define do
  factory :server_address do
    server
    value { 'example.com' }
  end
end
