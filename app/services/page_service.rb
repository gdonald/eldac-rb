# frozen_string_literal: true

class PageService
  attr_reader :q, :page

  def initialize(params)
    @q = params[:q]
    @page = params[:page] || 1
  end

  def search
    return Page.none if q.blank?

    pages = Page.search_by_term(q).page(page).per(10)

    pages = ServerSearchService.search(q) if pages.total_pages.zero?

    pages
  end
end
