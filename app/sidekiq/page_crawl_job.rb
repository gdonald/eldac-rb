# frozen_string_literal: true

class PageCrawlJob
  include Sidekiq::Job

  def perform(id)
    page_crawl = PageCrawl.find(id)
    return unless page_crawl

    page_crawl.run!

    service = PageCrawlService.new(page_crawl.page)

    begin
      service.crawl!
      page_crawl.complete!
    rescue StandardError => e
      page_crawl.error = e.message
      page_crawl.fail!
    end
  end
end
