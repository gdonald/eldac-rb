# frozen_string_literal: true

class UrlService
  attr_reader :uri, :scheme, :host

  def initialize(url)
    url = "https://#{url}" unless url =~ %r{^https?://}

    @uri = URI(url)
    @scheme = Scheme.find_by(name: uri.scheme)
  end

  def save! # rubocop:disable Metrics/AbcSize
    return unless uri && scheme && uri.host.present?

    ActiveRecord::Base.transaction do
      host = Host.find_or_create_by(scheme:, name: uri.host)
      path = Path.find_or_create_by(host:, value: uri.path)
      query = Query.find_or_create_by(path:, value: uri.query)
      page = Page.find_or_create_by(query:)
      PageCrawl.find_or_create_by(page:) if host.crawl_allowed?
    end
  end

  def self.reset!(name)
    Url.where('value LIKE ?', "%#{name}%")
       .where(aasm_state: %w[completed failed])
       .update_all(aasm_state: 'created') # rubocop:disable Rails/SkipsModelValidations
  end
end
