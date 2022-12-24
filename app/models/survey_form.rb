# frozen_string_literal: true

class SurveyForm < ApplicationRecord
  belongs_to :survey
  belongs_to :form

  validates :survey_id, presence: true
  validates :form_id, presence: true
end
