# frozen_string_literal: true

class HtmlService
  attr_reader :page, :doc

  def initialize(html)
    @page = html.page
    @doc = html.doc
  end

  def build!
    page.blurb = blurb
    page.content = content
    page.save!

    find_hrefs
    find_phrases
  end

  private

  def blurb
    elem = nil
    %w[h1 h2 h3 h4 h5 p].each do |tag|
      elem ||= doc.search(tag).first
    end

    Sanitize.fragment(elem.to_s).strip
  end

  def content
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
    words.grep(/^[a-zA-Z]+$/)
  end

  def remove_stop_words(words)
    words.map(&:downcase) - Clean::STOP_WORDS
  end

  def remove_html_tags(text)
    Sanitize.fragment(text).gsub("\n", ' ').gsub("\r", '').gsub(/\s+/, ' ').strip
  end

  def find_hrefs
    doc.search('a').each do |a|
      href = a.attribute_nodes.select { |attr| attr.name == 'href' }.first&.value
      next unless href

      create_url(href)
    end
  end

  def create_url(href)
    value = (href.start_with?('http') ? href : URI.join(page.base_url, href).to_s).downcase

    url = Url.find_by(value:)
    Url.create!(value:) unless url
  end

  def find_phrases
    words = page.content.split
    offset = 0
    while offset < words.length
      [2, 3, 4].each do |length|
        slice = words[offset...(offset + length)].uniq
        next unless slice.length == length

        create_phrases(slice)
      end
      offset += 1
    end
  end

  def create_phrases(words)
    rotations = words.length
    while rotations.positive?
      rotations -= 1
      text = words.join(' ')
      phrase = Phrase.find_by(text:)
      next if phrase

      Phrase.create!(text:)
      words.rotate!
    end
  end
end
