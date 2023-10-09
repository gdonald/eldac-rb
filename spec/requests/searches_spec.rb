# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches' do
  describe 'GET /search' do
    context 'without a search term' do
      it 'renders search results' do
        get '/search'

        aggregate_failures do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe 'GET /search/autocomplete' do
    let(:json) { response.parsed_body }

    context 'with a matching phrase' do
      let!(:phrase) { create(:phrase, text: 'test') }

      it 'returns json results' do
        get '/search/autocomplete', params: { q: 'test', format: :json }

        aggregate_failures do
          expect(response).to have_http_status(:success)
          expect(json.first).to eq(phrase.text)
        end
      end
    end

    context 'with no matching phrase' do
      it 'returns empty json results' do
        get '/search/autocomplete', params: { q: 'test', format: :json }

        aggregate_failures do
          expect(response).to have_http_status(:success)
          expect(json).to be_empty
        end
      end
    end

    context 'with no query' do
      it 'returns empty json results' do # rubocop:disable RSpec/ExampleLength
        create(:phrase, text: 'test')

        get '/search/autocomplete', params: { format: :json }

        aggregate_failures do
          expect(response).to have_http_status(:success)
          expect(json).to be_empty
        end
      end
    end
  end
end
