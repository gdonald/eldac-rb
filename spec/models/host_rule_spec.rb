# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HostRule do
  subject(:host_rule) { create(:host_rule) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }

  describe '#add_url' do
    let(:host_rule) { build(:host_rule) }

    before { create(:scheme) }

    it 'creates a page crawl' do
      expect { host_rule.save! }.to change(PageCrawl, :count).by(1)
    end
  end

  describe '.ransackable_attributes' do
    it 'returns an array of strings' do
      expect(described_class.ransackable_attributes)
        .to match_array(%w[id name allowed created_at updated_at])
    end
  end

  describe '#downcase_name' do
    let(:host_rule) { build(:host_rule, name: 'EXAMPLE.COM') }

    it 'downcases the name' do
      expect { host_rule.save }
        .to change(host_rule, :name)
        .from('EXAMPLE.COM')
        .to('example.com')
    end
  end

  describe 'scopes' do
    before do
      create(:host_rule)
      create(:host_rule, :denied)
    end

    describe '.allowed' do
      it 'returns only allowed host rules' do
        aggregate_failures do
          expect(described_class.allowed.count).to eq(1)
          expect(described_class.allowed.first.allowed).to be(true)
        end
      end
    end

    describe '.denied' do
      it 'returns only denied host rules' do
        aggregate_failures do
          expect(described_class.denied.count).to eq(1)
          expect(described_class.denied.first.allowed).to be(false)
        end
      end
    end
  end
end
