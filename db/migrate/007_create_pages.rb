# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.references :query, null: false, foreign_key: true
      t.string :title, limit: 255
      t.text :blurb, limit: 1024
      t.text :content, limit: 262_143
      t.timestamps
    end
    add_index :pages, :title, using: 'gin'
    add_index :pages, :blurb, using: 'gin'
    add_index :pages, :content, using: 'gin'
  end
end
