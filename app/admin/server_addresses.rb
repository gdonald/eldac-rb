# frozen_string_literal: true

# :nocov:
ActiveAdmin.register ServerAddress do
  menu parent: 'Remote', priority: 1

  permit_params :server_id, :value, :active

  index do
    selectable_column
    id_column
    column :server
    column :value
    column :active
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
