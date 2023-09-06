# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Page do
  subject(:page) { create(:page) }

  it { is_expected.to belong_to(:query) }
  it { is_expected.to have_many(:page_crawls).dependent(:destroy) }
  it { is_expected.to validate_length_of(:title).is_at_most(255) }
  it { is_expected.to validate_length_of(:content).is_at_most((2**18) - 1) }

  describe '.ransackable_attributes' do
    it 'returns an array of attributes' do
      expected = %w[id query_id title blurb content created_at updated_at]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end

  describe '.ransackable_associations' do
    it 'returns an array of attributes' do
      expected = %w[page_crawls query]
      expect(described_class.ransackable_associations).to match_array(expected)
    end
  end

  describe '#query_string' do
    let(:page) { create(:page, query:) }
    let(:query) { create(:query, path:) }
    let(:path) { create(:path) }

    it 'returns a query string' do
      expect(page.query_string).to eq("#{path.value}?#{query.value}")
    end

    context 'when the query value is nil' do
      let(:query) { create(:query, path:, value: nil) }

      it 'returns a query string' do
        expect(page.query_string).to eq(path.value)
      end
    end
  end

  describe '#base_url' do
    let(:page) { create(:page, query:) }
    let(:query) { create(:query, path:) }
    let(:path) { create(:path, host:) }
    let!(:host) { create(:host) }

    it 'returns a base url' do
      expect(page.base_url).to eq("#{host.scheme.name}://#{host.name}")
    end
  end

  describe '#url' do
    let(:page) { create(:page, query:) }
    let(:query) { create(:query, path:) }
    let(:path) { create(:path, host:) }
    let!(:host) { create(:host) }

    it 'returns a base url' do
      expect(page.url).to eq("#{host.scheme.name}://#{host.name}#{path.value}?#{query.value}")
    end
  end
end
