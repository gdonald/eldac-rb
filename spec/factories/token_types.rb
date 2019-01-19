# frozen_string_literal: true

FactoryBot.define do
  factory :token_type do
    name { 'Token Type' }

    trait :valid_token_type do
      name { Faker::Lorem.word }
    end
  end
end
