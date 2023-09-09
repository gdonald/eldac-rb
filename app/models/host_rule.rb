# frozen_string_literal: true

class HostRule < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :name, uniqueness: { case_sensitive: false }

  scope :allowed, -> { where(allowed: true) }
  scope :denied, -> { where(allowed: [nil, false]) }

  before_save :downcase_name
  after_commit :crawl

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name allowed created_at updated_at]
  end

  private

  def downcase_name
    self.name = name.downcase
  end

  def crawl
    return unless allowed?

    Scheme.find_each do |scheme|
      url = "#{scheme.name}://#{name}"
      UrlStorageService.new(url).save!
    end
  end
end
