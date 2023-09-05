# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    sequence(:title) { |n| "Page Title #{n}" }
    sequence(:content) { |n| "Content for page #{n} goes here. Some more content." }
    query
  end
end
