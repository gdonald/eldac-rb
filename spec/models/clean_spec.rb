# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clean do
  describe 'STOP_WORDS' do
    it 'contains words' do
      aggregate_failures do
        expect(Clean::STOP_WORDS).to be_an(Array)
        expect(Clean::STOP_WORDS).to include('the')
        expect(Clean::STOP_WORDS.uniq).to eq(Clean::STOP_WORDS)
      end
    end
  end
end
