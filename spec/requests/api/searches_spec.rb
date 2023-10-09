# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Searches' do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/search', params: { q: 'foo', format: :json }
      expect(response).to have_http_status(:success)
    end

    it 'redirects html requests' do
      get '/api/search', params: { q: 'foo', format: :html }
      expect(response).to redirect_to(root_path)
    end
  end
end
