# frozen_string_literal: true

class HtmlService
  attr_reader :html

  def initialize(html)
    @html = html
  end

  def build!
    page = html.page
    doc = Nokogiri::HTML(html.content)

    page.blurb = blurb(doc)
    page.content = content(doc)
    page.save!

    find_hrefs(doc, page)
  end

  private

  def blurb(doc)
    elem = nil
    %w[h1 h2 h3 h4 h5 p].each do |tag|
      elem ||= doc.search(tag).first
    end

    elem.to_s.gsub(/<.*?>/, '').strip
  end

  def content(doc)
    text = remove_html_tags(doc.to_s)
    words = remove_non_words(text.split)
    words = remove_stop_words(words)
    words = remove_small_words(words)

    words.join(' ').strip[0..2712]
  end

  def remove_small_words(words)
    words.select { |word| word.length > 1 }
  end

  def remove_non_words(words)
    words.grep(/^[a-z]+$/)
  end

  def remove_stop_words(words)
    words.map(&:downcase) - Clean::STOP_WORDS
  end

  def remove_html_tags(text)
    text.gsub(/<.*?>/, '').gsub("\n", ' ').gsub("\r", '').gsub(/\s+/, ' ').strip
  end

  def find_hrefs(doc, page)
    doc.search('a').each do |a|
      href = a.attribute_nodes.select { |attr| attr.name == 'href' }.first&.value
      next unless href

      create_url(href, page)
    end
  end

  def create_url(href, page)
    value = (href.start_with?('http') ? href : URI.join(page.base_url, href).to_s).downcase

    url = Url.find_by(value:)
    Url.create!(value:) unless url
  end
end
