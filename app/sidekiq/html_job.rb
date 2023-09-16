# frozen_string_literal: true

class HtmlJob
  include Sidekiq::Job

  def perform(id)
    html = Html.find(id)
    return unless html

    html.run!

    service = HtmlService.new(html)
    begin
      service.build!
      html.complete!
    rescue StandardError => e
      html.error = e.message
      html.fail!
    end
  end
end
