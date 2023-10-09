# frozen_string_literal: true

module ServerSearchService
  include Headers

  def self.search(term) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    server = Server.first
    return Page.none unless server

    address = server.server_addresses.first
    return Page.none unless address

    url = "https://#{address.value}/search?q=#{term}"

    response = HTTParty.get(url, { headers: })
    json = JSON.parse(response.body)

    pages = []
    json['pages'].each do |page|
      pages << Page.new(title: page['title'], blurb: page['blurb'], content: page['content'])
    end

    pages
  end
end
