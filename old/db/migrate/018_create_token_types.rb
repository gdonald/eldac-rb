# frozen_string_literal: true

class CreateTokenTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :token_types do |t|
      t.string :name, null: false, limit: 32
    end
    add_index :token_types, :name, unique: true
  end
end
