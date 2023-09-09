# frozen_string_literal: true

class CrawlSchedulerJob < ApplicationJob
  queue_as :default

  def perform
    PageCrawl.created.find_each do |page_crawl|
      host = page_crawl.page.query.path.host
      next unless host.last_crawled_at.nil? || host.last_crawled_at < time_ago

      host.update!(last_crawled_at: Time.zone.now)
      CrawlJob.perform_later(page_crawl.id)
    end
  end

  private

  def time_ago
    ENV.fetch('HOST_THROTTLE', 900).to_i.seconds.ago
  end
end
