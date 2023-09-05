# frozen_string_literal: true

class UrlStorageService
  attr_reader :uri, :scheme

  def initialize(str)
    @uri = URI(str)
    @scheme = Scheme.find_by(name: uri.scheme)
  end

  def save!
    ActiveRecord::Base.transaction do
      page = save_page!(save_query!(save_path!(save_host!)))

      page_crawl = PageCrawl.create!(page:)
      CrawlJob.perform_later(page_crawl.id)
    end
  end

  private

  def save_host!
    host = Host.find_by(scheme:, name: uri.host)
    host ||= Host.create!(scheme:, name: uri.host)
    host
  end

  def save_path!(host)
    path = Path.find_by(host:, value: uri.path)
    path ||= Path.create!(host:, value: uri.path)
    path
  end

  def save_query!(path)
    query = Query.find_by(path:, value: uri.query)
    query ||= Query.create!(path:, value: uri.query)
    query
  end

  def save_page!(query)
    page = Page.find_by(query:)
    page ||= Page.create!(query:)
    page
  end
end
