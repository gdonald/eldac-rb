# frozen_string_literal: true

FactoryBot.define do
  factory :scheme do
    name { 'http' }

    trait :https do
      name { 'https' }
    end
  end
end
