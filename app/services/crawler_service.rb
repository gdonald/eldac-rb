# frozen_string_literal: true

class CrawlerService
  include HTTParty

  def crawl!(page)
    response = HTTParty.get(page.url, { headers: })
    doc = Nokogiri::HTML(response.body)

    page.title = doc.title
    page.html = html(doc)

    # TODO: Extract content from HTML

    page.save!
  end

  private

  def headers
    { 'User-Agent' => 'Eldac/1.0 (https://eldac.io)' }
  end

  def html(doc)
    doc.at('body').children.to_s.strip
       .gsub(/>[\s]+</, '><')
       .gsub(/\n\s+/, ' ')
  end
end
