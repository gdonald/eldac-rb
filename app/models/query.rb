# frozen_string_literal: true

class Query < ApplicationRecord
  belongs_to :path

  validates :value, length: { maximum: 1024 }

  before_save :downcase_value

  def self.ransackable_attributes(_auth_object = nil)
    %w[id path_id value created_at updated_at]
  end

  private

  def downcase_value
    return if value.blank?

    self.value = value.downcase
  end
end
