# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.references :page, index: true, foreign_key: true
      t.string :name, index: true, limit: 64
      t.integer :fields_count, null: false, default: 0
      t.integer :position, index: true, null: false, default: 0
    end
    add_index :sections, %i[page_id name], unique: true
  end
end
