# frozen_string_literal: true

class CreateHtmls < ActiveRecord::Migration[7.1]
  def change
    create_table :htmls do |t|
      t.references :page, null: false, foreign_key: true
      t.string :aasm_state, null: false
      t.text :content
      t.text :error
      t.timestamps
    end
  end
end
