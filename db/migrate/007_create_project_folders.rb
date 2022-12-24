# frozen_string_literal: true

class CreateProjectFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :project_folders do |t|
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.references :folder, index: true, foreign_key: true
    end
    add_index :project_folders, %i[user_id project_id folder_id], unique: true, name: :user_proj_fold
  end
end
