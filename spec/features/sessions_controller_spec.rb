# frozen_string_literal: true

require 'rails_helper'

describe 'using the sessions controller', type: :feature do
  describe 'to login' do
    let(:user) { create(:user, :valid_user) }

    it 'anon user fails to login', js: true do
      expect do
        visit login_path
        expect(page).to have_content 'Login'
        click_on('submit')
        expect(page).to have_content 'Login failed'
      end.to change(ActiveRecord::SessionStore::Session, :count)
    end

    it 'unknown user fails to login', js: true do
      expect do
        visit login_path
        expect(page).to have_content 'Login'
        fill_in('Email', with: Faker::Internet.email)
        click_on('submit')
      end.to change(ActiveRecord::SessionStore::Session, :count)
      expect(page).to have_content 'Login failed'
    end

    it 'login to a user account', js: true do
      expect do
        visit login_path
        expect(page).to have_content 'Login'
        fill_in('Email', with: user.email)
        fill_in('Password', with: 'changeme')
        click_on('submit')
        expect(page).to have_content 'Projects'
      end.to change(ActiveRecord::SessionStore::Session, :count)
    end
  end

  describe 'to logout' do
    let(:user) { create(:user, :valid_user) }

    it 'user logs out', js: true do
      expect do
        visit logout_path
        expect(page).to have_content 'Login'
      end.to change(ActiveRecord::SessionStore::Session, :count)
    end
  end
end
