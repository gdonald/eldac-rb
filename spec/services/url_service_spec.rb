# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlService do
  subject(:service) { described_class.new(url) }

  let(:url) { 'https://example.com' }

  before do
    create_lookup_data
  end

  describe '#save!' do
    it 'creates a page' do
      expect { service.save! }.to change(Page, :count).by(1)
    end

    context 'with a bad url' do
      let(:url) { 'https' }

      it 'creates a page crawl' do
        expect { service.save! }.not_to change(PageCrawl, :count)
      end
    end
  end

  def create_lookup_data
    create(:scheme)
    create(:scheme, :http)
  end
end
