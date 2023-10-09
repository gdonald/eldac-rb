# frozen_string_literal: true

FactoryBot.define do
  factory :host do
    scheme
    sequence(:name) { |n| "n#{n}.example.com" }
  end
end
