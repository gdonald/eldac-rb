# frozen_string_literal: true

class CreatePaths < ActiveRecord::Migration[7.0]
  def change
    create_table :paths do |t|
      t.references :host, null: false, foreign_key: true
      t.string :value, null: false, index: true, limit: (2**10) - 1
      t.timestamps
    end
    add_index :paths, %i[host_id value], unique: true
  end
end
