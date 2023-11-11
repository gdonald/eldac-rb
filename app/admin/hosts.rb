# frozen_string_literal: true

# :nocov:
ActiveAdmin.register Host do
  menu parent: 'Content', priority: 1

  remove_filter :scheme
  remove_filter :paths

  index do
    selectable_column
    id_column
    column :scheme
    column :name
    column('Paths') do |host|
      host.paths.limit(10).collect do |path|
        link_to(path.value, "/admin/paths/#{path.id}") if path.value.present?
      end.compact.join(', ').html_safe
    end
    column :last_crawled_at
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
