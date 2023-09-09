# frozen_string_literal: true

# :nocov:
ActiveAdmin.register PageCrawl do
  preserve_default_filters!
  remove_filter :page
  filter :aasm_state, as: :select, collection: -> { PageCrawl.aasm.states.map(&:name) }

  index do
    selectable_column
    id_column
    column('Title') do |page_crawl|
      link_to page_crawl.page.title, admin_page_path(page_crawl.page)
    end
    column('Url') do |page_crawl|
      link_to page_crawl.page.url, admin_page_path(page_crawl.page)
    end
    column :aasm_state
    column :error
    column :created_at
    column :updated_at
    actions
  end
end
# :nocov:
