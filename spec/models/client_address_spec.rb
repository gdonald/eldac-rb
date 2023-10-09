# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientAddress do
  subject(:client_address) { create(:client_address) }

  it { is_expected.to belong_to(:client) }
  it { is_expected.to validate_presence_of(:value) }

  describe '.ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expected = %w[active created_at id client_id updated_at value]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end
end
