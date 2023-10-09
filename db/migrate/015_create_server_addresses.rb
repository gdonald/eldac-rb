# frozen_string_literal: true

class CreateServerAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :server_addresses do |t|
      t.references :server, null: false, foreign_key: true
      t.string :value, null: false
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
