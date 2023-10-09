# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    sequence(:value) { |n| "https://n#{n}.example.com" }

    trait :completed do
      aasm_state { 'completed' }
    end
  end
end
