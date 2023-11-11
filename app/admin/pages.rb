# frozen_string_literal: true

# :nocov:
ActiveAdmin.register Page do
  remove_filter :query
  remove_filter :page_crawls

  index do
    selectable_column
    id_column
    column('Url') do |page|
      link_to page.url, admin_url_path(page.url)
    end
    column :title
    column :blurb
    column('Content') do |html|
      html.content.blank? ? '' : html.content[0..256]
    end
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
