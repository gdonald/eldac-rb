# frozen_string_literal: true

class UrlJobFactory
  include Sidekiq::Job

  def perform
    Url.created.limit(8).each_with_index do |url, index|
      seconds = index * 6
      UrlJob.perform_in(seconds, url.id)
    end
  end
end
