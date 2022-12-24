# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(response).to render_template(:application)
    end
  end

  describe 'POST #create' do
    it 'invalid user renders new form' do
      expect do
        post :create, params: { user: { fname: '' } }
      end.to change(User, :count).by(0)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(response).to render_template(:application)
    end

    it 'valid user info redirects' do
      expect do
        post :create, params: { user: attributes_for(:user, email: Faker::Internet.email) }
      end.to change(User, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
