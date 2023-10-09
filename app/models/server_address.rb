# frozen_string_literal: true

class ServerAddress < ApplicationRecord
  belongs_to :server

  validates :value, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[active created_at id server_id updated_at value]
  end
end
