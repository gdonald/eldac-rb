# frozen_string_literal: true

class UrlJob
  include Sidekiq::Job
  attr_reader :service_klass

  sidekiq_options retry: 1

  def initialize(service_klass = UrlService)
    @service_klass = service_klass
  end

  def perform(id)
    url = Url.find_by(id:)
    return unless url.created?

    run!(url)
  end

  private

  def run!(url)
    url.run!
    service = service_klass.new(url.value)
    begin
      service.save!
      url.complete!
    rescue StandardError => e
      url.error = e.message
      url.fail!
    end
  end
end
