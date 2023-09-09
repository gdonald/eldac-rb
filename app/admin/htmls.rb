# frozen_string_literal: true

# :nocov:
ActiveAdmin.register Html do
  remove_filter :page

  index do
    selectable_column
    id_column
    column :page
    column :aasm_state
    column :error
    column('Content') do |html|
      html.content[0..127]
    end
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
