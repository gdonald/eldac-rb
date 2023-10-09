# frozen_string_literal: true

class Url < ApplicationRecord
  include AASM

  aasm do
    state :created, initial: true
    state :running, :completed, :failed

    event :run do
      transitions from: :created, to: :running
    end

    event :complete do
      transitions from: :running, to: :completed
    end

    event :fail do
      transitions from: :running, to: :failed
    end
  end

  validates :value, presence: true
  validates :value, uniqueness: { case_sensitive: false }

  scope :created, -> { where(aasm_state: 'created') }

  before_save :downcase_value

  def self.ransackable_attributes(_auth_object = nil)
    %w[aasm_state created_at error id updated_at value]
  end

  private

  def downcase_value
    self.value = value.downcase
  end
end
