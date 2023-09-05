# frozen_string_literal: true

class PageCrawl < ApplicationRecord
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
end
