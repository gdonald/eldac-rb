# frozen_string_literal: true

FactoryBot.define do
  factory :page_crawl do
    page

    trait :running do
      aasm_state { 'running' }
    end
  end
end
