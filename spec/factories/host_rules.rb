# frozen_string_literal: true

FactoryBot.define do
  factory :host_rule do
    sequence(:name) { |n| "n#{n}.example.com" }
    allowed { true }

    trait(:denied) do
      allowed { false }
    end
  end
end
