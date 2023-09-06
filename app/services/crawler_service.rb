# frozen_string_literal: true

class CrawlerService
  include HTTParty

  def crawl!(page)
    response = HTTParty.get(page.url, { headers: })
    return unless html?(response)

    doc = Nokogiri::HTML(response.body)

    page.title = doc.title
    page.save!

    html = Html.create!(page:, content: html(doc))
    HtmlContentJob.perform_later(html.id)
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

  def html?(response)
    return false unless response && response.headers['content-type']

    response.headers['content-type'].include?('text/html')
  end
end
