# frozen_string_literal: true

class CreatePhrases < ActiveRecord::Migration[7.1]
  def change
    create_table :phrases do |t|
      t.string :text, null: false, index: { unique: true }, limit: 255
      t.integer :length, null: false, index: true
      t.timestamps
    end
  end
end
