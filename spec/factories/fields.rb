# frozen_string_literal: true

FactoryBot.define do
  factory :field do
    name { 'Field Name' }
    field_type
    section
  end
end
