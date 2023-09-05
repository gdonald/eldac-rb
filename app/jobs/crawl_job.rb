# frozen_string_literal: true

class CrawlJob < ApplicationJob
  attr_reader :service

  queue_as :default

  def initialize(service = CrawlerService.new)
    @service = service
    super
  end

  def perform(id)
    page_crawl = PageCrawl.find(id)
    page_crawl.run!

    begin
      service.crawl!(page_crawl.page)
      page_crawl.complete!
    rescue StandardError => e
      page_crawl.error = e.message
      page_crawl.fail!
    end
  end
end
