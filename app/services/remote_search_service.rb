# frozen_string_literal: true

module RemoteSearchService
  include Headers

  def self.search(term) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    server = Server.first
    return Page.none unless server

    address = server.server_addresses.first
    return Page.none unless address

    url = "#{scheme.name}://#{address.value}#{port}/api/search?q=#{term}"

    response = HTTParty.get(url, { headers: })
    json = JSON.parse(response.body)

    pages = []
    json['pages'].each do |page|
      pages << RemotePage.new(title: page['title'], blurb: page['blurb'], content: page['content'], url: page['url'])
    end

    pages
  end

  class << self
    def scheme
      name = Rails.env.production? ? 'https' : 'http'
      Scheme.find_by(name:)
    end

    def port
      Rails.env.production? ? '' : ':3000'
    end
  end
end
