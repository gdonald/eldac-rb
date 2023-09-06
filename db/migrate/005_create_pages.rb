# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.references :query, null: false, foreign_key: true
      t.string :title, index: true, limit: (2**8) - 1
      t.string :blurb, index: true, limit: (2**10) - 1
      t.text :content, index: true, limit: (2**18) - 1
      t.timestamps
    end
  end
end
