# frozen_string_literal: true

class Html < ApplicationRecord
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

  belongs_to :page

  def doc
    @doc ||= Nokogiri::HTML(content)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id page_id aasm_state content error created_at updated_at]
  end
end
