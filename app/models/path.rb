# frozen_string_literal: true

class Path < ApplicationRecord
  belongs_to :host
  has_many :queries, dependent: :destroy

  validates :value, length: { maximum: 1024 }

  before_save :downcase_value

  def self.ransackable_attributes(_auth_object = nil)
    %w[id host_id value created_atupdated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[host queries]
  end

  private

  def downcase_value
    self.value = value.downcase
  end
end
