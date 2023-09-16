# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageCrawlJob do
  subject(:page_crawl_job) { described_class.new(service_klass) }

  let(:service_klass) { PageCrawlService }
  let(:service) { instance_double(PageCrawlService) }
  let(:page_crawl) { create(:page_crawl) }

  before do
    allow(service_klass).to receive(:new).and_return(service)
  end

  describe '#perform' do
    it 'runs the page crawl' do
      allow(service).to receive(:crawl!).and_return(true)
      page_crawl_job.perform(page_crawl.id)
      expect(page_crawl.reload).to be_completed
    end

    context 'with a failure' do
      before do
        allow(service).to receive(:crawl!).and_raise(StandardError, 'error')
        page_crawl_job.perform(page_crawl.id)
        page_crawl.reload
      end

      it 'fails the page crawl' do
        expect(page_crawl).to be_failed
      end

      it 'saves an error' do
        expect(page_crawl.error).to eq('error')
      end
    end
  end
end
