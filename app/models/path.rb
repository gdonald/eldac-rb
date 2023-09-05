# frozen_string_literal: true

class Path < ApplicationRecord
  belongs_to :host
  has_many :queries, dependent: :destroy

  validates :value, presence: true, length: { maximum: 1023 }
end
