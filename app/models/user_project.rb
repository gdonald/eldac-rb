# frozen_string_literal: true

class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :relationship

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :relationship_id, presence: true, uniqueness: { scope: %i[user_id project_id] }
end
