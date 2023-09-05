# frozen_string_literal: true

class Page < ApplicationRecord
  belongs_to :query
  has_many :page_crawls, dependent: :destroy

  validates :title, length: { maximum: 255 }
  validates :content, length: { maximum: (2**18) - 1 }

  scope :by_term, lambda { |term|
    pages = Page

    t = Page.arel_table
    query = term.downcase.gsub(/[^-a-z0-9_ ]/, '')
    qs = / /.match?(query) ? query.split : [query]
    qs.each do |q|
      q = "%#{q}%"
      pages = pages.where(t[:title].matches(q).or(t[:content].matches(q)))
    end

    pages
  }

  def url
    "#{base_url}#{query_string}"
  end

  def base_url
    host = query.path.host
    "#{host.scheme.name}://#{host.name}"
  end

  def query_string
    "#{query.path.value}?#{query.value}"
  end
end
