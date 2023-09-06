# frozen_string_literal: true

class HtmlContentJob < ApplicationJob
  attr_reader :service

  queue_as :default

  def initialize(service = HtmlContentService.new)
    @service = service
    super
  end

  def perform(id)
    html = Html.find(id)
    html.run!

    begin
      service.build!(html)
      html.complete!
    rescue StandardError => e
      html.error = e.message
      html.fail!
    end
  end
end
