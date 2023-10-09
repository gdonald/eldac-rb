# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhraseService do
  subject(:service) { described_class.new(params) }

  let(:result) { service.search }

  context 'when params are empty' do
    let(:params) { {} }

    it 'returns empty array' do
      expect(result).to be_empty
    end
  end

  context 'when params and results are present' do
    let(:params) { { q: 'foo' } }

    it 'returns array of pages' do
      create(:phrase, text: 'foo bar')

      expect(result).to eq(['foo bar'])
    end
  end
end
