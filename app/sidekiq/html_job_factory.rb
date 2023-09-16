# frozen_string_literal: true

class HtmlJobFactory
  include Sidekiq::Job

  def perform
    Html.created.limit(10).find_each do |html|
      HtmlJob.perform_async(html.id)
    end
  end
end
