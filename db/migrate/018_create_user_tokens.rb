# frozen_string_literal: true

class CreateUserTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tokens do |t|
      t.references :user, foreign_key: true
      t.references :token_type, foreign_key: true
      t.string :token, index: true, limit: 80
    end
    add_index :user_tokens, %i[user_id token_type_id], unique: true
  end
end
