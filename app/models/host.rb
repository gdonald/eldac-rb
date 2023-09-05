# frozen_string_literal: true

class Host < ApplicationRecord
  belongs_to :scheme
  has_many :paths, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, uniqueness: { scope: :scheme_id, case_sensitive: false }
end
