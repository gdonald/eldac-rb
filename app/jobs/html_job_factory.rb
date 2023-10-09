# frozen_string_literal: true

class HtmlJobFactory
  include Sidekiq::Job

  def perform
    Html.created.limit(12).each_with_index do |html, index|
      seconds = index * 4
      HtmlJob.perform_in(seconds, html.id)
    end
  end
end
