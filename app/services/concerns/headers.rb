# frozen_string_literal: true

module Headers
  extend ActiveSupport::Concern

  class_methods do
    def headers
      { 'User-Agent' => ENV.fetch('USER_AGENT', 'Example/1.0 (https://example.com)') }
    end
  end

  def headers
    self.class.headers
  end
end
