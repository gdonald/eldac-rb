# frozen_string_literal: true

class PhraseService
  attr_reader :q

  def initialize(params)
    @q = params[:q]
  end

  def search
    return Phrase.none if q.blank?

    Phrase.search_by_term(q).map(&:text)
  end
end
