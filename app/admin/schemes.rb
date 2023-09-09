# frozen_string_literal: true

# :nocov:
ActiveAdmin.register Scheme do
  remove_filter :hosts

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
