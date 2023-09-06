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
    str = query.path.value
    str += "?#{query.value}" if query.value.present?
    str
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id query_id title blurb content created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[page_crawls query]
  end
end
