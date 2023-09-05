# frozen_string_literal: true

class CreateCrawlJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :crawl_jobs do |t|
      t.references :page, null: false, foreign_key: true
      t.string :aasm_state, null: false
      t.timestamps
    end
  end
end
