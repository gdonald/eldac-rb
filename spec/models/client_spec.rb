# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client do
  subject(:client) { create(:client) }

  it { is_expected.to validate_presence_of(:requests_per_hour) }
  it { is_expected.to validate_numericality_of(:requests_per_hour).only_integer.is_greater_than_or_equal_to(0) }

  describe '#active' do
    context 'when active' do
      it 'is valid' do
        aggregate_failures do
          expect(client.active).to be_truthy
          expect(client).to be_valid
        end
      end
    end

    context 'when inactive' do
      before { client.update(active: false) }

      it 'is valid' do
        aggregate_failures do
          expect(client.active).to be_falsey
          expect(client).to be_valid
        end
      end
    end
  end

  describe '.ransackable_attributes' do
    it 'returns an array of strings' do
      expected = %w[name public_key active created_at id requests_per_hour updated_at]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end

  describe '.ransackable_associations' do
    it 'returns an array of strings' do
      expected = %w[client_addresses]
      expect(described_class.ransackable_associations).to match_array(expected)
    end
  end
end
