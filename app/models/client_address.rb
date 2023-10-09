# frozen_string_literal: true

class ClientAddress < ApplicationRecord
  belongs_to :client

  validates :value, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[active client_id created_at id updated_at value]
  end
end
