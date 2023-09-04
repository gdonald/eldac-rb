# frozen_string_literal: true

class Page < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :title, presence: true
  validates :content, presence: true

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
end
