# # frozen_string_literal: true

# # :nocov:
# ActiveAdmin.register Url do
#   menu parent: 'Pages', priority: 0

#   preserve_default_filters!
#   filter :aasm_state, as: :select, collection: -> { Url.aasm.states.map(&:name) }

#   permit_params :value, :aasm_state

#   remove_filter :hosts

#   index do
#     selectable_column
#     id_column
#     column :value
#     column :aasm_state
#     column('Error') do |url|
#       content_tag :pre do
#         content_tag :code, url.error
#       end
#     end
#     column :created_at
#     column :updated_at
#     actions
#   end

#   form do |f|
#     f.inputs do
#       f.input :value
#       f.input :aasm_state, as: :select, collection: Url.aasm.states.map(&:name)
#     end
#     f.actions
#   end
# end
# # :nocov:
