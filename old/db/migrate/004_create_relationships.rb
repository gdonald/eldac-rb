# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.string :name, limit: 64, null: false
    end
    add_index :relationships, :name, unique: true
  end
end
