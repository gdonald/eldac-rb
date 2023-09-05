# frozen_string_literal: true

class CreateSchemes < ActiveRecord::Migration[7.0]
  def change
    create_table :schemes do |t|
      t.string :name, null: false, index: { unique: true }, limit: (2**3) - 1
      t.timestamps
    end
  end
end
