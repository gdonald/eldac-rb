# frozen_string_literal: true

class UrlStorageService
  attr_reader :uri, :scheme

  def initialize(str)
    url = PageView.find_by(url: str)
    return if url

    @uri = URI(str)
    @scheme = Scheme.find_by(name: uri.scheme)
  end

  def save!
    return unless uri && scheme

    ActiveRecord::Base.transaction do
      host = save_host!
      path = save_path!(host)
      query = save_query!(path)
      save_page!(query)
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

    crawl_page!(page)

    page
  end

  def crawl_page!(page)
    return unless host_crawl_allowed

    page_crawl = PageCrawl.find_by(page:)
    return if page_crawl

    PageCrawl.create!(page:)
  end

  def host_crawl_allowed
    host_rule = HostRule.find_by(name: uri.host)

    case ENV.fetch('HOST_RULE_DEFAULT', 'deny')
    when 'deny'
      host_rule&.allowed?
    when 'allow'
      host_rule.nil? || !host_rule.allowed?
    else
      raise 'Invalid HOST_RULE_DEFAULT value'
    end
  end
end
