# frozen_string_literal: true

class HtmlJob
  include Sidekiq::Job
  attr_reader :service_klass

  def initialize(service_klass = HtmlService)
    @service_klass = service_klass
  end

  def perform(id)
    html = Html.find(id)
    return unless html

    build!(html)
  end

  private

  def build!(html)
    html.run!
    service = service_klass.new(html)
    begin
      service.build!
      html.complete!
    rescue StandardError => e
      html.error = e.message
      html.fail!
    end
  end
end
