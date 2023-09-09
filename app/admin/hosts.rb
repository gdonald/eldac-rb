# frozen_string_literal: true

# :nocov:
ActiveAdmin.register Host do
  remove_filter :scheme
  remove_filter :paths

  index do
    selectable_column
    id_column
    column :scheme
    column :name
    column('Paths') do |host|
      host.paths.collect do |path|
        link_to(path.value, "/admin/paths/#{path.id}") if path.value.present?
      end.compact.join(', ').html_safe # rubocop:disable Rails/OutputSafety
    end
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
