# frozen_string_literal: true

ActiveAdmin.register PageCrawl do
  remove_filter :page

  index do
    selectable_column
    id_column
    column('Page') do |page_crawl|
      link_to page_crawl.page.title, admin_page_path(page_crawl.page)
    end
    column :aasm_state
    column :error
    column :created_at
    column :updated_at
    actions
  end
end
