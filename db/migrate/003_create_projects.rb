# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, index: true, limit: 64, null: false
      t.integer :surveys_count, null: false, default: 0
      t.integer :forms_count, null: false, default: 0
      t.boolean :deleted, index: true, default: false
    end
  end
end
