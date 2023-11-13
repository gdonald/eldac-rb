# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RemoteSearchService do
  subject(:service) { described_class.new(term) }

  describe '.search' do
    let(:result) { service.search }
    let(:term) { 'term' }
    let(:pages) { { 'pages' => [{ 'title' => 'title', 'url' => 'url', 'blurb' => 'blurb' }] } }

    before do
      allow(ENV).to receive(:fetch).with('RSA_PRIVATE_KEY', nil).and_return('private_key')
      allow(ENV).to receive(:fetch).with('RSA_ALGO', nil).and_return('algorithm')
      allow(ENV).to receive(:fetch).with('USER_AGENT', 'Example/1.0 (https://example.com)').and_return('user_agent')
      allow(OpenSSL::PKey::RSA).to receive(:new)
      allow(JWT).to receive(:encode).and_return('data')
      # allow(HTTParty).to receive(:post).and_return(double(body:))
      allow(RequestUrl).to receive(:url).and_return('http://example.com:3000/api/search')
    end

    context 'with no server' do
      it 'returns an empty array' do
        stub_request(:post, 'http://example.com:3000/api/search')
          .with(
            body: '{"data":"data","algorithm":"algorithm"}',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type' => 'application/json',
              'User-Agent' => 'user_agent'
            }
          )
          .to_return(status: 200, body: { pages: [] }.to_json, headers: {})

        expect(result).to eq([])
      end
    end

    context 'with a server with no address' do
      before { create(:server) }

      it 'returns an empty array' do
        stub_request(:post, 'http://example.com:3000/api/search')
          .with(
            body: '{"data":"data","algorithm":"algorithm"}',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type' => 'application/json',
              'User-Agent' => 'user_agent'
            }
          )
          .to_return(status: 200, body: { pages: [] }.to_json, headers: {})

        expect(result).to eq([])
      end
    end

    context 'with a server with an address' do
      # let(:body) { pages.to_json }
      let(:body) { { data: '', algorithm: '' }.to_json }

      before do
        create(:server_address)
        create(:scheme, :http)
      end

      it 'returns an array' do
        stub_request(:get, 'http://example.com:3000/api/search?q=term')
          .with(headers: { 'User-Agent' => 'ELDAC/1.0 (https://eldac.io)' })
          .to_return(status: 200, body:, headers: {})

        expect(result.first.title).to eq('title')
      end

      context 'with a production environment' do
        before do
          allow(Rails.env).to receive(:production?).and_return(true)
          create(:scheme)
        end

        it 'returns an array' do
          stub_request(:post, 'http://example.com:3000/api/search')
            .with(
              # body: '{"data":"data","algorithm":"algorithm"}',
              headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Content-Type' => 'application/json',
                'User-Agent' => 'user_agent'
              }
            )
            .to_return(status: 200, body:, headers: {})

          expect(result.first.title).to eq('title')
        end
      end
    end
  end
end
