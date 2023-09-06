# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Query do
  subject(:query) { create(:query) }

  it { is_expected.to belong_to(:path) }
  it { is_expected.to validate_length_of(:value).is_at_most(1023) }

  describe '.ransackable_attributes' do
    it 'returns an array of attributes' do
      expected = %w[id path_id value created_at updated_at]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end
end
