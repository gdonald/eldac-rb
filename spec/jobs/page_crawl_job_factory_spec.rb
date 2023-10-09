# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageCrawlJobFactory do
  subject(:factory) { described_class.new }

  describe '#perform' do
    let!(:page_crawl) { create(:page_crawl) }

    it 'creates jobs with increasing delay' do
      allow(PageCrawlJob).to receive(:perform_in)
      factory.perform

      expect(PageCrawlJob).to have_received(:perform_in).with(0, page_crawl.id)
    end
  end
end
