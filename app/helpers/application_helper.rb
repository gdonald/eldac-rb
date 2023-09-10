# frozen_string_literal: true

module ApplicationHelper
  def site_name
    ENV.fetch('SITE_NAME', 'ELDAC')
  end
end
