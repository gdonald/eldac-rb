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

  describe '#crawl_allowed?' do
    context 'when HOST_RULE_DEFAULT is deny' do
      it 'returns false' do
        expect(host).not_to be_crawl_allowed
      end

      it 'returns true' do
        create(:host_rule, name: host.name)

        expect(host).to be_crawl_allowed
      end
    end

    context 'when HOST_RULE_DEFAULT is allow' do
      before do
        allow(ENV).to receive(:fetch).and_return('allow')
      end

      it 'returns true' do
        expect(host).to be_crawl_allowed
      end

      it 'returns false' do
        create(:host_rule, :denied, name: host.name)

        expect(host).not_to be_crawl_allowed
      end
    end

    context 'when HOST_RULE_DEFAULT is invalid' do
      before do
        allow(ENV).to receive(:fetch).and_return('invalid')
      end

      it 'raises an error' do
        expect { host.crawl_allowed? }.to raise_error('Invalid HOST_RULE_DEFAULT value')
      end
    end
  end
end
