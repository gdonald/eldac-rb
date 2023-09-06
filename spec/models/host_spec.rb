# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Host do
  subject(:host) { create(:host) }

  it { is_expected.to belong_to(:scheme) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:scheme_id).case_insensitive }

  describe '.ransackable_attributes' do
    it 'returns an array of attributes' do
      expected = %w[id scheme_id name created_at updated_at]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end

  describe '.ransackable_associations' do
    it 'returns an array of attributes' do
      expected = %w[paths scheme]
      expect(described_class.ransackable_associations).to match_array(expected)
    end
  end
end
