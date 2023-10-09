# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageService do
  subject(:service) { described_class.new(params) }

  let(:result) { service.search }

  context 'when params are empty' do
    let(:params) { {} }

    it 'returns empty array' do
      expect(result).to be_empty
    end
  end

  context 'when params and results are present' do
    let(:params) { { q: 'test' } }
    let!(:page) { create(:page, title: 'Test Page') }

    it 'returns array of pages' do
      expect(result).to eq([page])
    end
  end

  context 'when params are present and no local results' do
    let(:params) { { q: 'test' } }

    it 'calls ServerSearchService' do
      allow(ServerSearchService).to receive(:search)
      result
      expect(ServerSearchService).to have_received(:search).with('test')
    end
  end
end
