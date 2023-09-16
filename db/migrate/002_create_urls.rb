# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :value, null: false, unique: true
      t.string :aasm_state, null: false, index: true
      t.text :error
      t.timestamps
    end
  end
end
