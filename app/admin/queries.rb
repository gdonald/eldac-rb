# frozen_string_literal: true

ActiveAdmin.register Query do
  remove_filter :path

  index do
    selectable_column
    id_column
    column('Path') do |query|
      link_to query.path.value, admin_path_path(query.path)
    end
    column :value
    column :created_at
    column :updated_at
    actions
  end
end
