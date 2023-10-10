# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageCrawl do
  subject(:page_crawl) { create(:page_crawl) }

  it { is_expected.to belong_to(:page) }

  describe 'aasm' do
    let(:page_crawl) { described_class.new }

    it { is_expected.to have_state(:created) }
    it { is_expected.to transition_from(:created).to(:running).on_event(:run) }
    it { is_expected.to transition_from(:running).to(:completed).on_event(:complete) }
    it { is_expected.to transition_from(:running).to(:failed).on_event(:fail) }
  end

  describe '.ransackable_attributes' do
    it 'returns an array of attributes' do
      expected = %w[id page_id aasm_state error created_at updated_at]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end

  describe '.ransackable_associations' do
    it 'returns an array of associations' do
      expected = %w[host page path query]
      expect(described_class.ransackable_associations).to match_array(expected)
    end
  end

  describe '.crawlable' do
    let!(:page_crawl) { create(:page_crawl, query:) }
    let(:query) { create(:query, path:) }
    let(:path) { create(:path, host:) }
    let(:host) { create(:host, last_crawled_at: nil) }

    it 'returns a relation' do
      expect(described_class.crawlable.first).to eq(page_crawl)
    end

    context 'when host has been crawled recently' do
      let(:host) { create(:host, last_crawled_at: Time.zone.now) }

      it 'returns empty array' do
        expect(described_class.crawlable).to be_empty
      end
    end
  end

  describe '.host_wait' do
    it 'returns a time' do
      expect(described_class.host_wait).to be_a(Time)
    end
  end

  describe '#update_last_crawled' do
    let(:page_crawl) { create(:page_crawl, :running) }
    let(:host) { page_crawl.host }

    it 'updates the last_crawled_at attribute' do
      expect do
        page_crawl.complete!
      end.to(change(host, :last_crawled_at))
    end
  end
end
