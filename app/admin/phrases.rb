# frozen_string_literal: true

# :nocov:
ActiveAdmin.register Phrase do
  menu parent: 'Content', priority: 5

  remove_filter :length

  index do
    selectable_column
    id_column
    column :text
    column :length
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
