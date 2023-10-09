# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServerAddress do
  subject(:server_address) { create(:server_address) }

  it { is_expected.to belong_to(:server) }
  it { is_expected.to validate_presence_of(:value) }

  describe '.ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expected = %w[active created_at id server_id updated_at value]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end
end
