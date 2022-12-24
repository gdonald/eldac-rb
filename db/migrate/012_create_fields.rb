# frozen_string_literal: true

class CreateFields < ActiveRecord::Migration[7.0]
  def change
    create_table :fields do |t|
      t.references :section, index: true, foreign_key: true
      t.references :field_type, index: true, foreign_key: true
      t.string :name, index: true, limit: 64
      t.string :default, limit: 255
      t.integer :field_opts_count, null: false, default: 0
      t.integer :position, index: true, null: false, default: 0
    end
    add_index :fields, %i[section_id name], unique: true
  end
end
