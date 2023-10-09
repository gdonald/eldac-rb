# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phrase do
  subject(:phrase) { create(:phrase) }

  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_uniqueness_of(:text) }
  it { is_expected.to validate_length_of(:text).is_at_most(255) }

  describe '#search_by_term' do
    let(:result) { described_class.search_by_term('foo') }

    context 'when there are no matching phrases' do
      it 'returns nothing' do
        expect(result).to be_empty
      end
    end

    context 'when there are matching phrases' do
      it 'returns a result' do
        create(:phrase, text: 'foo bar')

        aggregate_failures do
          expect(result.count).to eq(1)
          expect(result.first.text).to eq('foo bar')
        end
      end
    end
  end

  describe '.ransackable_attributes' do
    it 'returns the correct attributes' do
      expect(described_class.ransackable_attributes)
        .to match_array(%w[created_at id text updated_at])
    end
  end

  describe '.ransackable_associations' do
    it 'returns the correct associations' do
      expect(described_class.ransackable_associations).to be_empty
    end
  end

  describe '#set_length' do
    it 'sets the length' do
      expect(phrase.length).to eq(phrase.text.length)
    end
  end
end
