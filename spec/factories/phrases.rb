# frozen_string_literal: true

FactoryBot.define do
  factory :phrase do
    sequence(:text) { |n| "phrase#{n} text" }
  end
end
