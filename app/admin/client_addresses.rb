# frozen_string_literal: true

# :nocov:
ActiveAdmin.register ClientAddress do
  menu parent: 'Remote', priority: 1

  permit_params :client_id, :value, :active

  index do
    selectable_column
    id_column
    column :client
    column :value
    column :active
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
