# frozen_string_literal: true

class CreateClientAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :client_addresses do |t|
      t.references :client, null: false, foreign_key: true
      t.string :value, null: false
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
