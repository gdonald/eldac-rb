# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Query do
  subject(:query) { create(:query) }

  it { is_expected.to belong_to(:path) }
  it { is_expected.to validate_length_of(:value).is_at_most(1024) }

  describe '.ransackable_attributes' do
    it 'returns an array of attributes' do
      expected = %w[id path_id value created_at updated_at]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end

  describe '#downcase_value' do
    context 'when value is nil' do
      let(:query) { build(:query, value: nil) }

      it 'does not change value' do
        expect { query.save }.not_to(change(query, :value))
      end
    end

    context 'when value is not blank' do
      let(:query) { build(:query, value: 'VALUE') }

      it 'downcases value' do
        expect { query.save }.to(change(query, :value).to('value'))
      end
    end
  end
end
