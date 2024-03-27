# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search' do
  describe 'Searching' do
    context 'with a search term and results' do
      it 'renders search results' do # rubocop:disable RSpec/ExampleLength
        create(:page, content: 'Test Content')

        visit root_path

        within 'form' do
          fill_in('q', with: 'test')
          click_on(id: 'search')
        end

        expect(page).to have_css('p', text: 'Search results for "test":')
      end
    end

    context 'with a search term and no results' do
      it 'renders no search results' do # rubocop:disable RSpec/ExampleLength
        visit root_path

        within 'form' do
          fill_in('q', with: 'test')
          click_on(id: 'search')
        end

        expect(page).to have_css('p', text: 'No remote search results found for "test"')
      end
    end

    context 'without a search term' do
      it 'renders no search results' do
        visit root_path

        within 'form' do
          click_on(id: 'search')
        end

        expect(page).to have_css('h1', text: 'ELDAC')
      end
    end
  end
end
