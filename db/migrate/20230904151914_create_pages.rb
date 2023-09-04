# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :url, null: false, index: { unique: true }
      t.string :title, null: false, index: true
      t.string :content, null: false, index: true
      t.timestamps
    end
  end
end
