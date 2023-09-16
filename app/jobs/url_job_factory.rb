# frozen_string_literal: true

class UrlJobFactory
  include Sidekiq::Job

  def perform
    Url.created.limit(100).find_each do |url|
      UrlJob.perform_async(url.id)
    end
  end
end
