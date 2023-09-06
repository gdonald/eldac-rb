# frozen_string_literal: true

class Path < ApplicationRecord
  belongs_to :host
  has_many :queries, dependent: :destroy

  validates :value, length: { maximum: 1023 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id host_id value created_atupdated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[host queries]
  end
end
