# frozen_string_literal: true

class CreateServers < ActiveRecord::Migration[7.1]
  def change
    create_table :servers do |t|
      t.string :name, null: false, index: { unique: true }, limit: 255
      t.integer :requests_per_hour, null: false, default: 0
      t.boolean :active, null: false, default: true
      t.text :public_key
      t.timestamps
    end
  end
end
