# frozen_string_literal: true

class RequestUrl
  attr_reader :address

  def initialize
    # TODO: Make this dynamic, distributed
    server = Server.first
    @address = server&.server_addresses&.first
  end

  def url
    return unless scheme && address

    "#{scheme.name}://#{address.value}#{port}/api/search"
  end

  def scheme
    name = Rails.env.production? ? 'https' : 'http'
    Scheme.find_by(name:)
  rescue StandardError
    logger.error("Invalid scheme name '#{name}'")
  end

  def port
    Rails.env.production? ? '' : ':3000'
  end

  def self.url
    RequestUrl.new.url
  end
end
