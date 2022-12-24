# frozen_string_literal: true

class CreateFieldCalcs < ActiveRecord::Migration[5.2]
  def change
    create_table :field_calcs do |t|
      t.references :field, index: true, foreign_key: true
      t.text :content, limit: 1024
    end
  end
end
