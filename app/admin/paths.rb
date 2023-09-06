# frozen_string_literal: true

ActiveAdmin.register Path do
  remove_filter :host
  remove_filter :queries

  index do
    selectable_column
    id_column
    column :host
    column :value
    column :created_at
    column :updated_at
    actions
  end
end
