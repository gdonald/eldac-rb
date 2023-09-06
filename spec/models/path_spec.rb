# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Path do
  subject { create(:path) }

  it { is_expected.to belong_to(:host) }
  it { is_expected.to have_many(:queries).dependent(:destroy) }
  it { is_expected.to validate_length_of(:value).is_at_most(1023) }

  describe '.ransackable_attributes' do
    it 'returns an array of attributes' do
      expected = %w[id host_id value created_atupdated_at]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end

  describe '.ransackable_associations' do
    it 'returns an array of attributes' do
      expected = %w[host queries]
      expect(described_class.ransackable_associations).to match_array(expected)
    end
  end
end
