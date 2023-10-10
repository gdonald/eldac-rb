# frozen_string_literal: true

class PageCrawlService
  include HTTParty
  include Headers

  attr_reader :page

  def initialize(page)
    @page = page
  end

  def crawl!
    response = HTTParty.get(page.url, { headers: })
    return unless html?(response)

    doc = Nokogiri::HTML(response.body)
    page.update!(title: doc.title)

    Html.create!(page:, content: html(doc))
  end

  private

  def html(doc)
    doc.at('body').children.to_s.strip
       .gsub(/>\s+</, '><')
       .gsub(/\n\s+/, ' ')
  end

  def html?(response)
    return false unless response && response.headers['content-type']

    response.headers['content-type'].include?('text/html')
  end
end
