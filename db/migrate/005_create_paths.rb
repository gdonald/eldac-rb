# frozen_string_literal: true

class CreatePaths < ActiveRecord::Migration[7.1]
  def change
    create_table :paths do |t|
      t.references :host, null: false, foreign_key: true
      t.text :value, null: false, index: true, limit: 1024
      t.timestamps
    end
  end
end
