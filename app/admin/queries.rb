# # frozen_string_literal: true

# # :nocov:
# ActiveAdmin.register Query do
#   menu parent: 'Content', priority: 3

#   remove_filter :path

#   index do
#     selectable_column
#     id_column
#     column('Path') do |query|
#       link_to query.path.value, admin_path_path(query.path)
#     end
#     column('Value') do |query|
#       query.value || 'nil'
#     end
#     column :created_at
#     column :updated_at
#     actions
#   end
# end
# # :nocov:
