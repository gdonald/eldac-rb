# frozen_string_literal: true

FactoryBot.define do
  factory :host do
    scheme { Scheme.find_or_create_by(name: 'http') }
    sequence(:name) { |n| "n#{n}.example.com" }
  end
end
