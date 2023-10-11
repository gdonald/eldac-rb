# frozen_string_literal: true

class Page < ApplicationRecord
  include PgSearch::Model

  belongs_to :query
  has_many :page_crawls, dependent: :destroy

  validates :title, length: { maximum: 255 }
  validates :content, length: { maximum: 262_144 }

  scope :search_by_term, lambda { |term|
    by_term(term)
      .includes(query: { path: { host: :scheme } })
  }

  # pg_search_scope :by_term,
  #                 against: {
  #                   content: 'A',
  #                   title: 'B',
  #                   blurb: 'C'
  #                 },
  #                 using: {
  #                   trigram: {},
  #                   dmetaphone: {},
  #                   tsearch: { prefix: true }
  #                 }

  pg_search_scope :by_term,
                  against: {
                    content: 'A',
                    title: 'B',
                    blurb: 'C'
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
