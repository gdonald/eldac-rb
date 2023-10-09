# frozen_string_literal: true

class PageCrawlJobFactory
  include Sidekiq::Job

  def perform
    PageCrawl.crawlable.limit(10).each_with_index do |page_crawl, index|
      seconds = index * 5
      PageCrawlJob.perform_in(seconds, page_crawl.id)
    end
  end
end
