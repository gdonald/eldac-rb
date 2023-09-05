# frozen_string_literal: true

class Query < ApplicationRecord
  belongs_to :path

  validates :value, length: { maximum: 1023 }
end
