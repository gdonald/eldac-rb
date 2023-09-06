# frozen_string_literal: true

ActiveAdmin.register Page do
  remove_filter :query
  remove_filter :page_crawls

  index do
    selectable_column
    id_column
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
