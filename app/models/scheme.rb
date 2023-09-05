# frozen_string_literal: true

class Scheme < ApplicationRecord
  has_many :hosts, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 8 }
end
