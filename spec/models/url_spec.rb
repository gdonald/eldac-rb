# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url do
  subject(:url) { create(:url) }

  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_uniqueness_of(:value).case_insensitive }

  describe 'aasm' do
    let(:url) { described_class.new }

    it { is_expected.to have_state(:created) }
    it { is_expected.to transition_from(:created).to(:running).on_event(:run) }
    it { is_expected.to transition_from(:running).to(:completed).on_event(:complete) }
    it { is_expected.to transition_from(:running).to(:failed).on_event(:fail) }
  end

  describe '.ransackable_attributes' do
    it 'returns an array of attributes' do
      expected = %w[aasm_state created_at error id updated_at value]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end

  describe '#downcase_value' do
    it 'downcases value' do
      url.value = 'HTTPS://EXAMPLE.COM'
      expect { url.save }.to(change(url, :value).to('https://example.com'))
    end
  end

  describe '#created' do
    let!(:created) { create(:url) }

    before do
      create(:url).run!
    end

    it 'returns urls with created state' do
      aggregate_failures do
        expect(described_class.created.count).to eq(1)
        expect(described_class.created.first).to eq(created)
      end
    end
  end
end
