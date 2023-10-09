# frozen_string_literal: true

class CreateHosts < ActiveRecord::Migration[7.1]
  def change
    create_table :hosts do |t|
      t.references :scheme, null: false, foreign_key: true
      t.string :name, null: false, limit: 255
      t.timestamp :last_crawled_at, null: true, default: nil
      t.timestamps
    end
    add_index :hosts, %i[scheme_id name], unique: true
  end
end
