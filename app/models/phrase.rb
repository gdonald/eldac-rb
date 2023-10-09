# frozen_string_literal: true

class Phrase < ApplicationRecord
  validates :text, presence: true, uniqueness: true, length: { maximum: 255 }

  scope :search_by_term, lambda { |term|
    select('text')
      .where('text ILIKE ?', "#{term}%")
      .order(:text, :length)
      .limit(8)
  }

  before_save :set_length

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id text updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  private

  def set_length
    self.length = text.length
  end
end
