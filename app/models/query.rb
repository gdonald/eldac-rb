# frozen_string_literal: true

class Query < ApplicationRecord
  belongs_to :path

  validates :value, length: { maximum: 1023 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id path_id value created_at updated_at]
  end
end
