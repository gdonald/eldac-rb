# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrawlerService do
  subject(:service) { described_class.new }

  let(:page) { create(:page) }
  let(:body) do
    <<~HTML
      <html>
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
      service.crawl!(page)
      page.reload
      expect(page.title).to eq('Page Title')
    end

    it 'saves html' do
      expect do
        service.crawl!(page)
      end.to change(Html, :count).by(1)
    end

    it 'saves html content' do
      service.crawl!(page)
      expect(Html.last.content).to eq('<p>Content</p>')
    end

    it 'creates an html content job' do
      allow(HtmlContentJob).to receive(:perform_later)
      service.crawl!(page)
      expect(HtmlContentJob).to have_received(:perform_later).once
    end
  end
end
