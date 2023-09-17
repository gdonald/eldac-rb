# frozen_string_literal: true

class UrlService
  attr_reader :uri, :scheme, :host

  def initialize(str)
    url = PageView.find_by(url: str)
    return if url

    @uri = URI(str)
    @scheme = Scheme.find_by(name: uri.scheme)
  end

  def save!
    return unless uri && scheme && uri.host.present?

    ActiveRecord::Base.transaction do
      host = save_host!
      path = save_path!(host)
      query = save_query!(path)
      page = save_page!(query)
      crawl_page!(page)
    end
  end

  private

  def save_host!
    name = uri.host.downcase
    Host.find_or_create_by(scheme:, name:)
  end

  def save_path!(host)
    value = uri.path&.downcase
    Path.find_or_create_by(host:, value:)
  end

  def save_query!(path)
    value = uri.query&.downcase
    Query.find_or_create_by(path:, value:)
  end

  def save_page!(query)
    Page.find_or_create_by(query:)
  end

  def crawl_page!(page)
    return unless host_crawl_allowed

    PageCrawl.find_or_create_by(page:)
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
