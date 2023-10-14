# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RemoteSearches' do
  describe 'GET /index' do
    it 'returns http success' do
      get '/remote_search'
      expect(response).to have_http_status(:success)
    end
  end
end
