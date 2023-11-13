# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Searches' do
  describe 'GET /index' do
    let(:json) { response.parsed_body }

    context 'with no client' do
      it 'returns http success' do
        post '/api/search', params: { q: 'foo', format: :json }

        aggregate_failures do
          expect(response).to have_http_status(:success)
          expect(json['pages']).to be_empty
        end
      end

      it 'redirects html requests' do
        post '/api/search', params: { q: 'foo', format: :html }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with a client' do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:client_address) { create(:client_address) }
      let(:client) { client_address.client }
      let(:data) { 'data' }
      let(:pkey) { instance_double(OpenSSL::PKey::RSA) }
      let(:private_key) { 'private_key' }
      let(:algorithm) { 'RS256' }

      before do
        client_address

        allow_any_instance_of(ActionDispatch::Request) # rubocop:disable RSpec/AnyInstance
          .to receive(:remote_addr).and_return(client_address.value)

        allow(ENV).to receive(:fetch).with('RSA_PRIV_KEY', nil).and_return(private_key)
        allow(ENV).to receive(:fetch).with('RSA_ALGO', nil).and_return(algorithm)

        allow(OpenSSL::PKey::RSA).to receive(:new).with(private_key).and_return(pkey)

        allow(pkey).to receive(:sign)

        allow(JWT).to receive(:encode).and_return(data)

        allow(JWT).to receive(:decode).and_return([{ 'q' => 'foo' }, { 'alg' => algorithm }])
      end

      it 'returns http success' do
        post '/api/search', params: { data:, format: :json }

        aggregate_failures do
          expect(response).to have_http_status(:success)
          expect(json['pages']).to be_empty
        end
      end
    end
  end
end
