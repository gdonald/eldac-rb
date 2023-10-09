# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServerSearchService do
  subject(:klass) { described_class }

  describe '.search' do
    let(:result) { klass.search(term) }
    let(:term) { 'term' }
    let(:pages) { { 'pages' => [{ 'title' => 'title', 'url' => 'url', 'blurb' => 'blurb' }] } }

    context 'with no server' do
      it 'returns an empty array' do
        expect(result).to eq([])
      end
    end

    context 'with a server with no address' do
      before { create(:server) }

      it 'returns an empty array' do
        expect(result).to eq([])
      end
    end

    context 'with a server with an address' do
      let(:body) { pages.to_json }

      before { create(:server_address) }

      it 'returns an empty array' do
        stub_request(:get, 'https://example.com/search?q=term')
          .with(headers: { 'User-Agent' => 'ELDAC/1.0 (https://eldac.io)' })
          .to_return(status: 200, body:, headers: {})

        expect(result.first.title).to eq('title')
      end
    end
  end
end
