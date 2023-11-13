# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :client_addresses, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 1, maximum: 255 }

  validates :requests_per_hour, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :active, inclusion: { in: [true, false] }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name public_key active created_at id requests_per_hour updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[client_addresses]
  end

  def pub_key
    OpenSSL::PKey.read(public_key.gsub('\\n', "\n"))
  end
end
