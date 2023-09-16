# frozen_string_literal: true

# :nocov:
ActiveAdmin.register PageView do
  remove_filter :page

  index do
    column('Page') do |page_view|
      link_to page_view.page.title || 'Title Not Found', admin_page_path(page_view.page)
    end
    column('URL') do |page_view|
      link_to page_view.page.url, admin_page_path(page_view.page)
    end
    column :url
  end
end
# :nocov:
