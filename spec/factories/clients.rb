# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "Client #{n}" }
    requests_per_hour { 1000 }
    active { true }
    public_key { OpenSSL::PKey::RSA.new(2048).public_key.to_s }
  end
end
