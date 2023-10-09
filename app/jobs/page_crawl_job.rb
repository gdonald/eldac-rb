# frozen_string_literal: true

class PageCrawlJob
  include Sidekiq::Job
  attr_reader :service_klass

  sidekiq_options retry: 5

  def initialize(service_klass = PageCrawlService)
    @service_klass = service_klass
  end

  def perform(id)
    page_crawl = PageCrawl.find_by(id:)
    return unless page_crawl&.created?

    run!(page_crawl)
  end

  private

  def run!(page_crawl)
    page_crawl.run!
    service = service_klass.new(page_crawl.page)
    begin
      service.crawl!
      page_crawl.complete!
    rescue StandardError => e
      page_crawl.error = e.message
      page_crawl.fail!
    end
  end
end
