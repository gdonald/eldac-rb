# frozen_string_literal: true

class FieldType < ApplicationRecord
  has_many :fields, dependent: :destroy

  validates :name, presence: true, length: { maximum: 32 }, uniqueness: true

  scope :sorted, -> { order 'name' }

  def to_s
    name
  end
end
