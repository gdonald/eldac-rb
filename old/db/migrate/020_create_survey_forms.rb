# frozen_string_literal: true

class CreateSurveyForms < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_forms do |t|
      t.references :survey
      t.references :form
    end
  end
end
