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
  let(:response) { instance_double(HTTParty::Response, body:) }

  describe '#crawl!' do
    before do
      allow(HTTParty).to receive(:get).and_return(response)
    end

    it 'crawls the page' do
      service.crawl!(page)
      page.reload

      expect(page.title).to eq('Page Title')
    end
  end
end
