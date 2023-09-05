# frozen_string_literal: true

FactoryBot.define do
  factory :path do
    host
    sequence(:value) { |n| "/path#{n}" }
  end
end
