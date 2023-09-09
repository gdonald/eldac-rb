# frozen_string_literal: true

class CreatePageCrawls < ActiveRecord::Migration[7.0]
  def change
    create_table :page_crawls do |t|
      t.references :page, null: false, foreign_key: true, unique: true
      t.string :aasm_state, null: false
      t.text :error
      t.timestamps
    end
  end
end
