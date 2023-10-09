# frozen_string_literal: true

class Host < ApplicationRecord
  belongs_to :scheme
  has_many :paths, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: { scope: :scheme_id, case_sensitive: false }

  before_save :downcase_name

  def crawl_allowed?
    rule = HostRule.find_by(name:)

    case ENV.fetch('HOST_RULE_DEFAULT', 'deny')
    when 'deny'
      true if rule&.allowed?
    when 'allow'
      return true unless rule&.denied?

      false
    else
      raise 'Invalid HOST_RULE_DEFAULT value'
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id scheme_id name created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[paths scheme]
  end

  private

  def downcase_name
    self.name = name.downcase
  end
end
