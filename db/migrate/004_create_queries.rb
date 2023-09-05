# frozen_string_literal: true

class CreateQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :queries do |t|
      t.references :path, null: false, foreign_key: true
      t.string :value, limit: (2**10) - 1
      t.timestamps
    end
    add_index :queries, %i[path_id value], unique: true
  end
end
