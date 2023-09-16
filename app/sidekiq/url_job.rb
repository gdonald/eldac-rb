# frozen_string_literal: true

class UrlJob
  include Sidekiq::Job

  def perform(id)
    url = Url.find(id)
    return unless url

    url.run!

    service = UrlService.new(url.value)

    begin
      service.save!
      url.complete!
    rescue StandardError => e
      url.error = e.message
      url.fail!
    end
  end
end
