# frozen_string_literal: true

FactoryBot.define do
  factory :scheme do
    name { 'https' }

    trait :http do
      name { 'http' }
    end

    initialize_with { Scheme.find_or_create_by(name:) }
  end
end
