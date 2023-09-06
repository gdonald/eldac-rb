# frozen_string_literal: true

class HtmlContentService
  def build!(html)
    page = html.page
    doc = Nokogiri::HTML(html.content)

    page.blurb = blurb(doc)
    page.content = content(doc)
    page.save!

    find_hrefs(doc, page)
  end

  private

  def blurb(doc)
    h = doc.search('h1').first || doc.search('h2').first || doc.search('h3').first
    h.to_s.gsub(/<.*?>/, '').strip
  end

  def content(doc)
    doc.to_s.gsub(/<.*?>/, '').gsub("\n", ' ').gsub("\r", '').gsub(/\s+/, ' ').strip
  end

  def find_hrefs(doc, page)
    doc.search('a').each do |a|
      href = a.attribute_nodes.select { |attr| attr.name == 'href' }.first&.value
      next unless href

      create_url(href, page)
    end
  end

  def create_url(href, page)
    url = href.start_with?('http') ? href : URI.join(page.base_url, href).to_s
    UrlStorageService.new(url).save!
  end
end
