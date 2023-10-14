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
end
