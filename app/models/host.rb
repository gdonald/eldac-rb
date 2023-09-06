# frozen_string_literal: true

class Host < ApplicationRecord
  belongs_to :scheme
  has_many :paths, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: { scope: :scheme_id, case_sensitive: false }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id scheme_id name created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[paths scheme]
  end
end
