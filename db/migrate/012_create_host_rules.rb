# frozen_string_literal: true

class CreateHostRules < ActiveRecord::Migration[7.0]
  def change
    create_table :host_rules do |t|
      t.string :name, null: false, index: { unique: true }, limit: 255
      t.boolean :allowed, default: false, index: true, null: false
      t.timestamps
    end
  end
end
