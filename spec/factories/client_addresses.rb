# frozen_string_literal: true

FactoryBot.define do
  factory :client_address do
    client
    value { '127.0.0.1' }
  end
end
