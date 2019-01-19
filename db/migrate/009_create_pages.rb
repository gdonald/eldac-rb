# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :form, index: true, foreign_key: true
      t.string :name, null: false, index: true, limit: 64
      t.integer :position, index: true, null: false, default: 0
    end
    add_index :pages, %i[form_id name], unique: true
  end
end
