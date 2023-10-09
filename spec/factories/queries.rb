# frozen_string_literal: true

FactoryBot.define do
  factory :query do
    path
    sequence(:value) { |n| "query=#{n}" }
  end
end
