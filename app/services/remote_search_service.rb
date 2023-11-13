# frozen_string_literal: true

class RemoteSearchService
  attr_reader :term, :url

  def initialize(term)
    @term = term
    @url = RequestUrl.url
  end

  def search
    return [] unless json && json['pages']

    json['pages'].map do |page|
      RemotePage.new(title: page['title'], blurb: page['blurb'], content: page['content'], url: page['url'])
    end
  end

  private

  def request
    RequestEncoderService.new(term).encode
    # rescue StandardError
    #   Rails.logger.error('Failed to encode request')
    #   nil
  end

  def response
    r = request
    HTTParty.post(url, body: r[:body], headers: r[:headers])
    # rescue StandardError
    #   Rails.logger.error('Remote request failed')
    #   nil
  end

  def json
    JSON.parse(response.body)
    # rescue StandardError
    #   Rails.logger.error('Failed to parse response body')
    #   nil
  end
end
