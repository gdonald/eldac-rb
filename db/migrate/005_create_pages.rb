# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.references :query, null: false, foreign_key: true
      t.string :title, index: true, limit: 255
      t.text :blurb, index: true, limit: 1024
      t.text :content, index: true, limit: 262_143
      t.timestamps
    end
  end
end
