# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageCrawlService do
  subject(:service) { described_class.new(page) }

  let(:page) { create(:page) }
  let(:body) do
    <<~HTML
      <html lang="en">
        <head>
          <title>Page Title</title>
        </head>
        <body><p>Content</p></body>
      </html>
    HTML
  end
  let(:headers) { { 'content-type' => 'text/html' } }
  let(:response) { instance_double(HTTParty::Response, body:, headers:) }

  describe '#crawl!' do
    before do
      allow(HTTParty).to receive(:get).and_return(response)
    end

    it 'crawls the page' do
      service.crawl!
      page.reload
      expect(page.title).to eq('Page Title')
    end

    it 'saves html' do
      expect do
        service.crawl!
      end.to change(Html, :count).by(1)
    end

    it 'saves html content' do
      service.crawl!
      expect(Html.last.content).to eq('<p>Content</p>')
    end

    context 'when the response is not html' do
      let(:headers) { { 'content-type' => 'image/jpeg' } }

      it 'does not save html' do
        expect do
          service.crawl!
        end.not_to change(Html, :count)
      end
    end

    context 'when the response is not successful' do
      before do
        allow(HTTParty).to receive(:get).and_return(nil)
      end

      it 'does not save html' do
        expect do
          service.crawl!
        end.not_to change(Html, :count)
      end
    end
  end
end
