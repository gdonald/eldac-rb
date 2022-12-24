# frozen_string_literal: true

class Relationship < ApplicationRecord
  validates :name, presence: true, length: { maximum: 64 }, uniqueness: true

  def self.owner
    Relationship.where(name: 'owner').first
  end
end
