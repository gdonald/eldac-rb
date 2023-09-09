# frozen_string_literal: true

class Scheme < ApplicationRecord
  has_many :hosts, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 8 }

  before_save :downcase_name

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[hosts]
  end

  private

  def downcase_name
    self.name = name.downcase
  end
end
