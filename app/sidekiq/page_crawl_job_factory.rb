# frozen_string_literal: true

class PageCrawlJobFactory
  include Sidekiq::Job

  def perform
    PageCrawl.created.limit(10).find_each do |page_crawl|
      PageCrawlJob.perform_async(page_crawl.id)
    end
  end
end
