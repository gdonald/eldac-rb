# frozen_string_literal: true

class HostRule < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: { case_sensitive: false }

  scope :allowed, -> { where(allowed: true) }
  scope :denied, -> { where(allowed: [nil, false]) }

  before_save :downcase_name
  after_save :reset_urls, :add_url

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name allowed created_at updated_at]
  end

  def allowed?
    allowed == true
  end

  def denied?
    allowed == false
  end

  private

  def downcase_name
    self.name = name.downcase
  end

  def reset_urls
    UrlService.reset!(name)
  end

  def add_url
    UrlService.new(name).save!
  end
end
