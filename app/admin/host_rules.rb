# frozen_string_literal: true

# :nocov:
ActiveAdmin.register HostRule do
  permit_params :name, :allowed

  index do
    selectable_column
    id_column
    column :name
    column :allowed
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
