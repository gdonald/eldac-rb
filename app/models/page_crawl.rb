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
  has_one :query, through: :page
  has_one :path, through: :query
  has_one :host, through: :path

  scope :crawlable, lambda {
    joins(:host)
      .where(aasm_state: 'created')
      .and(
        where(hosts: { last_crawled_at: nil })
          .or(where('hosts.last_crawled_at < ?', host_wait))
      )
  }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id page_id aasm_state error created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[host page path query]
  end

  def self.host_wait
    ENV.fetch('HOST_THROTTLE_SECONDS', 900).to_i.seconds.ago
  end
end
