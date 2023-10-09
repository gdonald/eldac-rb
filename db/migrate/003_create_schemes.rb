# frozen_string_literal: true

class CreateSchemes < ActiveRecord::Migration[7.1]
  def change
    create_table :schemes do |t|
      t.string :name, null: false, index: { unique: true }, limit: 8
      t.timestamps
    end
  end
end
